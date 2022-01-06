import 'package:animations/animations.dart';
import 'package:charityapp/core/model/event_tab.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/detailFormJoining.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:charityapp/views/Pages/home_page/home_page.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<EventTitleCubit>(context).load(widget.eventId);
    BlocProvider.of<EventTabBloc>(context).add(LoadPagingView(
        eventId: widget.eventId,
        tab: EventTab.posts,
        startIndex: 0,
        number: 5));
    print('build event page');
    return Scaffold(
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
                      BlocProvider.of<EventTabBloc>(context).add(LoadEventView(
                        eventId: widget.eventId,
                        tab: currentTab,
                      ));
                    } else {
                      BlocProvider.of<EventTabBloc>(context).add(LoadPagingView(
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
                else if (state is EventLoadFailure) return Text('Error tab');

                if (state is EventPostViewSuccess) {
                  return SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (state as EventPostViewSuccess).posts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PostOverviewCard(post: state.posts[index]);
                      },
                    ),
                  );
                } else if (state is EventDetailViewSuccess) {
                  return IntroductionEventView(
                      detail: (state as EventDetailViewSuccess).detail);
                } else {
                  return Joiner(eventId: widget.eventId);
                }
                // return TabBarView(controller: _tabController, children: [
                //   Container(
                //     child: SingleChildScrollView(
                //       child: ListView.builder(
                //         shrinkWrap: true,
                //         physics: NeverScrollableScrollPhysics(),
                //         itemCount: (state as EventPostViewSuccess).posts.length,
                //         itemBuilder: (BuildContext context, int index) {
                //           return PostOverviewCard(post: state.posts[index]);
                //         },
                //       ),
                //     ),
                //   ),
                //   IntroductionEventView(
                //       detail: (state as EventDetailViewSuccess).detail),
                //   if (state is EventImagesViewSuccess) Text('Hình ảnh'),
                // ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class Joiner extends StatefulWidget {
  final String eventId;
  Joiner({Key? key, required this.eventId}) : super(key: key);

  @override
  _JoinerState createState() => _JoinerState();
}

class _JoinerState extends State<Joiner> {
  bool isTapJoiner = false;
  bool isTapJoining = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventTabBloc, EventTabState>(
      builder: (context, state) {
        return Column(
          children: [
            ExpansionTile(
                title: Text(
                  '25 người đang chờ duyệt',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  FormRegisterCard(
                    user: UserOverview(name: 'name'),
                    isFormRegister: true,
                  ),
                ]),
            ExpansionTile(
                title: Text(
                  '102 người đã tham gia',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                children: [
                  FormRegisterCard(
                    user: UserOverview(name: 'name'),
                    isFormRegister: false,
                  ),
                ]),
          ],
        );
      },
    );
  }
}

class FormRegisterCard extends StatelessWidget {
  final UserOverview user;
  final bool isFormRegister;
  const FormRegisterCard(
      {Key? key, required this.user, required this.isFormRegister})
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
                  image: user.avatarUri == null
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
        children: [
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
      subtitle: Text(
          "Đang theo dõi " + (user.address != null ? '- ${user.address}' : '')),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailFormJoinings(
              event: BaseEvent(
                  name: "Ủng hộ lũ lụt miền Trung",
                  creatorId: 'wxu87lK5Gabour4GQw0i4MDbdQl2'),
              userProfile: GetIt.instance.get<Authenticator>().userProfile,
            ),
          ),
        );
      },
    );
  }
}