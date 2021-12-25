import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  List<Post> posts = const <Post>[];
  String scrAvatar;
  String srcBackground;
  String eventName;

  EventPage(this.scrAvatar, this.srcBackground, this.eventName);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      Container(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return PostOverview(post: widget.posts[index]);
            },
          ),
        ),
      ),
      IntroductionEventView(),
      Text('Hình ảnh')
    ];

    TabController _tabController =
        new TabController(length: tabs.length, vsync: this);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverToBoxAdapter(
                child: EventOverview(widget.eventName, widget.scrAvatar),
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
                    ]),
              ),
            ];
          },
          body: Container(
            child: TabBarView(controller: _tabController, children: tabs),
          ),
        ),
      ),
    );
  }
}
