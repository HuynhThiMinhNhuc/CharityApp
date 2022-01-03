import 'package:charityapp/core/model/event_tab.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    else if (index == 2) currentTab = EventTab.image;

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
                  return Text('loading tab');
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
                }
                else if (state is EventDetailViewSuccess) {
                  return IntroductionEventView(
                      detail: (state as EventDetailViewSuccess).detail);

                } else {
                  return Joiner();
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

class Joiner extends StatelessWidget {
  const Joiner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _joinercontroller =
        new TextEditingController(text: "102  người đã tham gia ");
    TextEditingController _joiningcontroller =
        new TextEditingController(text: "   25  người đang chờ duyệt ");
    bool isTapJoiner = false;
    bool isTapJoining = false;
    return Column(
      children: [
        TextField(
          enabled: false,
          readOnly: true,
          controller: _joiningcontroller,
          style: TextStyle(fontWeight: FontWeight.w600),
          decoration: InputDecoration(
              suffixIcon: !isTapJoining
                  ? Icon(Icons.keyboard_arrow_down_rounded)
                  : Icon(Icons.keyboard_arrow_up_rounded)),
        ),
        Visibility(
          visible: isTapJoining ? true : false,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
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
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YXZhdGFyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    title: Text("Janny"),
                    subtitle: Text("Đang theo dõi - thành phố hồ chí minh"),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
