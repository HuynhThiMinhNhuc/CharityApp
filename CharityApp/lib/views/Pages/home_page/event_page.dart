import 'package:animations/animations.dart';
import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/core/model/event_tab.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/detailFormJoining.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:charityapp/views/Pages/home_page/home_page.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/form_bloc/form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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

class Joiner extends StatelessWidget {
  final String eventId;
  final EventPermission permission;
  final FormRegisterCubit _registerCubit = FormRegisterCubit();
  final FormRegisterCubit _paticipantsCubit = FormRegisterCubit();
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
  Widget build(BuildContext context) {
    return BlocBuilder<EventTabBloc, EventTabState>(
      builder: (context, state) {
        return Column(
          children: [
            if (permission == EventPermission.admin)
              buildExpansion(context, _registerCubit, true, numberRegister),
            buildExpansion(context, _paticipantsCubit, false, numberPaticipant),
          ],
        );
      },
    );
  }

  void onTabUser(BuildContext context) {
    final form = FormRegister(
        name: 'name',
        phone: 'phone',
        email: 'email',
        creatorId: 'creatorId',
        eventId: 'eventId',
        timeCreate: DateTime.now());
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailFormJoinings(
          formDetail: form,
          userProfile: GetIt.instance.get<Authenticator>().userProfile,
        ),
      ),
    );
  }

  Widget buildExpansion(BuildContext context, FormRegisterCubit cubit,
      bool isRegister, int number) {
    int valueNumber = number;

    return BlocConsumer<FormRegisterCubit, List<UserOverview>?>(
      bloc: cubit,
      listener: (_, listUser) {
        valueNumber = listUser?.length ?? valueNumber;
      },
      builder: (_, listUser) {
        return ExpansionTile(
          title: Text(
            isRegister
                ? '$valueNumber người đang chờ duyệt'
                : '$valueNumber người đã tham gia',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          children: listUser == null
              ? [Text('loading...')]
              : listUser
                  .map((user) => FormRegisterCard(
                      user: user,
                      isFormRegister: isRegister,
                      onTabUser: permission == EventPermission.admin
                          ? () => onTabUser(context)
                          : null))
                  .toList(),
          onExpansionChanged: (isExpansion) {
            if (isExpansion) {
              if (isRegister)
                cubit.loadRegisters(eventId);
              else
                cubit.loadPaticipants(eventId);
            } else {
              // cubit.reset();
            }
          },
        );
      },
    );
  }
}

class FormRegisterCard extends StatelessWidget {
  final UserOverview user;
  final bool isFormRegister;
  final Function()? onTabUser;

  const FormRegisterCard(
      {Key? key,
      required this.user,
      required this.isFormRegister,
      this.onTabUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 61,
        height: 61,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(colors: activecolor)),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              image: DecorationImage(
                  image: user.avatarUri == ""
                      ? AssetImage("asset/avatar.png") as ImageProvider
                      : NetworkImage(user.avatarUri!),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ),
      title: Text(user.name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: onTabUser == null
            ? const []
            : [
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.cancel_outlined),
                ),
                if (isFormRegister)
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.check_circle_outline),
                  ),
              ],
      ),
      subtitle: Text((user.address != null ? '${user.address}' : '')),
      onTap: () => onTabUser?.call(),
    );
  }
}
