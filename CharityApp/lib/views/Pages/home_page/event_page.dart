import 'package:charityapp/core/model/event_tab.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
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
                backgroundColor: Colors.white,
                title: TabBar(
                  indicatorColor: maincolor,
                  unselectedLabelColor: Color(0xFF757070),
                  controller: _tabController,
                  labelColor: maincolor,
                  tabs: [
                    Tab(text: "Trang chủ"),
                    Tab(text: "Giới thiệu"),
                    Tab(text: "Hình ảnh"),
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
                }
                else {
                  return Text('Hình ảnh');
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
