import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/core/model/event_tab.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/my_alert_dialog_2.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart' as bloc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/form_bloc/form_bloc.dart';
import '../../bloc/form_bloc/form_event.dart';

class EventPage extends StatefulWidget {
  final String eventId;
  EventPage({required this.eventId});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin {
  late TabController _tabController;
  EventPermission permission = EventPermission.admin;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<EventTitleCubit>(context).load(widget.eventId);
    BlocProvider.of<EventTabBloc>(context).add(LoadPagingView(
        eventId: widget.eventId,
        tab: EventTab.values[_tabController.index],
        startIndex: 0,
        number: 5));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build event page');
    return BlocListener<EventTitleCubit, EventTitleSuccess>(
      listener: (context, state) {
        permission = state.permission;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: EventOverviewCard(
                    eventId: widget.eventId,
                  ),
                ),
                SliverAppBar(
                  pinned: true,
                  stretch: true,
                  floating: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  title: TabBar(
                    indicatorColor: maincolor,
                    unselectedLabelColor: Color(0xFF757070),
                    controller: _tabController,
                    labelColor: maincolor,
                    labelStyle: kText15BoldMain,
                    tabs: [
                      Tab(text: "Trang chủ"),
                      Tab(text: "Giới thiệu"),
                      Tab(text: "Thành viên"),
                    ],
                    onTap: (index) {
                      late EventTab currentTab;
                      if (index == 0)
                        currentTab = EventTab.posts;
                      else if (index == 1)
                        currentTab = EventTab.description;
                      else if (index == 2) currentTab = EventTab.paticipants;

                      if (index != 0) {
                        BlocProvider.of<EventTabBloc>(context)
                            .add(LoadEventView(
                          eventId: widget.eventId,
                          tab: currentTab,
                        ));
                      } else {
                        BlocProvider.of<EventTabBloc>(context).add(
                            LoadPagingView(
                                eventId: widget.eventId,
                                tab: currentTab,
                                startIndex: 0,
                                number: 5));
                      }
                    },
                  ),
                ),
              ];
            },
            body: Container(
              child: BlocBuilder<EventTabBloc, EventTabState>(
                builder: (context, state) {
                  if (state is EventViewLoadInProgress)
                    return SketonEvent();
                  else if (state is EventPostViewSuccess) {
                    final rs = state;

                    return SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: rs.posts.length,
                        itemBuilder: (BuildContext _, int index) {
                          return PostOverviewCard(post: rs.posts[index]);
                        },
                      ),
                    );
                  } else if (state is EventDetailViewSuccess) {
                    return IntroductionEventView(detail: state.detail);
                  } else if (state is EventPaticipantsViewSuccess) {
                    return Joiner(
                      eventId: widget.eventId,
                      permission: permission,
                      numberRegister: state.numberFormRegister,
                      numberPaticipant: state.numberPaticipants,
                    );
                  } else
                    return Text('Error tab');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Joiner extends StatefulWidget {
  final String eventId;
  final EventPermission permission;
  final int numberRegister;
  final int numberPaticipant;

  Joiner({
    Key? key,
    required this.eventId,
    required this.permission,
    this.numberPaticipant = 0,
    this.numberRegister = 0,
  }) : super(key: key);

  @override
  State<Joiner> createState() => _JoinerState();
}

class _JoinerState extends State<Joiner> {
  final bloc.FormRegisterCubit _registerCubit = bloc.FormRegisterCubit();

  final bloc.FormRegisterCubit _paticipantsCubit = bloc.FormRegisterCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventTabBloc, EventTabState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              if (widget.permission == EventPermission.admin)
                buildExpansion(
                    context, _registerCubit, true, widget.numberRegister),
              buildExpansion(
                  context, _paticipantsCubit, false, widget.numberPaticipant),
            ],
          ),
        );
      },
    );
  }

  void onTabUser(BuildContext context, UserOverview user) {
    BlocProvider.of<FormBloc>(context)
        .add(LoadForm(eventId: widget.eventId, userId: user.id!));
    Navigator.of(context).pushNamed(AppRoutes.detailFormRegister);
  }

  Widget buildExpansion(BuildContext context, bloc.FormRegisterCubit cubit,
      bool isRegister, int number) {
    int valueNumber = number;

    return BlocConsumer<bloc.FormRegisterCubit, List<UserOverview>?>(
      bloc: cubit,
      listener: (_, listUser) {
        valueNumber = listUser?.length ?? valueNumber;
      },
      builder: (_, listUser) {
        return BlocListener<bloc.FormBloc, bloc.FormState>(
          listener: (context, state) {
            if (state is bloc.FormSuccess) {
              if (listUser?.any((user) => user.id! == state.userId) ?? false) {
                if (isRegister)
                  cubit.loadRegisters(widget.eventId);
                else
                  cubit.loadPaticipants(widget.eventId);
              }
            }
          },
          child: ExpansionTile(
            title: Text(
              isRegister
                  ? '$valueNumber người đang chờ duyệt'
                  : '$valueNumber người đã tham gia',
              style: kText16BoldBlack,
            ),
            children: listUser == null
                ? []
                : listUser
                    .map((user) => FormRegisterCard(
                        user: user,
                        eventId: widget.eventId,
                        permission: widget.permission,
                        isFormRegister: isRegister,
                        onTabUser: widget.permission == EventPermission.admin &&
                                isRegister
                            ? () => onTabUser(context, user)
                            : null))
                    .toList(),
            onExpansionChanged: (isExpansion) {
              if (isExpansion) {
                if (isRegister)
                  cubit.loadRegisters(widget.eventId);
                else
                  cubit.loadPaticipants(widget.eventId);
              } else {
                // cubit.reset();
              }
            },
          ),
        );
      },
    );
  }
}

class FormRegisterCard extends StatelessWidget {
  final UserOverview user;
  final String eventId;
  final bool isFormRegister;
  final Function()? onTabUser;
  final EventPermission permission;

  const FormRegisterCard(
      {Key? key,
      required this.user,
      required this.eventId,
      required this.permission,
      required this.isFormRegister,
      this.onTabUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 61.h,
        height: 61.h,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: activecolor)),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            width: 60.h,
            height: 60.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: DecorationImage(
                image: (user.avatarUri == "" || user.avatarUri == null)
                    ? AssetImage("asset/avatar.png") as ImageProvider
                    : NetworkImage(user.avatarUri!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      title: Text(
        user.name,
        style: kText15RegularBlack,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: permission != EventPermission.admin
            ? const []
            : [
                IconButton(
                  onPressed: () => onPressCancel(context),
                  icon: Icon(Icons.cancel_outlined),
                ),
                if (isFormRegister)
                  IconButton(
                    onPressed: () => onPressCheck(context),
                    icon: Icon(Icons.check_circle_outline),
                  ),
              ],
      ),
      subtitle: Text((user.address != null ? '${user.address}' : '')),
      onTap: () => onTabUser?.call(),
    );
  }

  void onPressCancel(BuildContext context) async {
    if (isFormRegister) {
      //Not allow to event
      BlocProvider.of<bloc.FormBloc>(context).add(bloc.ConfirmForm(
          eventId: eventId, userId: user.id!, isConfirm: false));
    } else {
      //Dismiss paticipants
      showDialog(
        context: context,
        builder: (builder) {
          return MyAlertDialog2(
            content: 'Bạn có muốn hủy hoạt động tham gia của người này không?',
            title: 'Thông báo',
            onTabYes: () {
              BlocProvider.of<bloc.FormBloc>(context)
                  .add(bloc.UnRegisterForm(eventId: eventId, userId: user.id!));
              Navigator.of(context).pop();
            },
          );
        },
      );
    }
  }

  void onPressCheck(BuildContext context) {
    BlocProvider.of<bloc.FormBloc>(context).add(
        bloc.ConfirmForm(eventId: eventId, userId: user.id!, isConfirm: true));
  }
}
