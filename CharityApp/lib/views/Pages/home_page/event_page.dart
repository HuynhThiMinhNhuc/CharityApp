import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:charityapp/views/bloc/event_bloc/event.dart';
import 'package:charityapp/views/bloc/post_bloc/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventPage extends StatefulWidget {
  final String? scrAvatar;
  final String? srcBackground;
  final String name;

  EventPage({this.scrAvatar, this.srcBackground, required this.name, scrBackground});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        length: 2, vsync: this); //Post tab and information event tab
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoadViewSuccess) {
          final eventInfor = state.event;

          return NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverToBoxAdapter(
                  child: EventOverviewCard(widget.name, widget.scrAvatar),
                ),
                SliverAppBar(
                  pinned: true,
                  backgroundColor: Colors.white,
                  title: TabBar(
                      indicatorColor: maincolor,
                      unselectedLabelColor: Color(0xFF757070),
                      controller: _tabController,
                      labelColor: maincolor,
                      tabs: [
                        Tab(text: "Trang chủ"),
                        Tab(text: "Giới thiệu"),
                      ]),
                ),
              ];
            },
            body: Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    Container(
                      child: BlocBuilder<PostBloc, PostState>(
                        builder: (context, state) {
                          if (state is PostsLoadSuccess) {
                            final posts = state.posts;
                            return SingleChildScrollView(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: posts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return PostOverviewCard(post: posts[index]);
                                },
                              ),
                            );
                          }
                          else return Text('Fail data');
                        },
                      ),
                    ),
                    IntroductionEventView(),
                  ],
                ),
              ),
            ),
          );
        } else
          return Text('Load fail');
      },
    );
  }
}
