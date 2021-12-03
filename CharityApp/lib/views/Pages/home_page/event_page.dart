import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventPage extends StatefulWidget {
  List<PostOverview> posts;
  String scrAvatar;
  String srcBackground;
  String eventName;

  EventPage(this.scrAvatar, this.srcBackground, this.eventName, this.posts);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> with TickerProviderStateMixin {
  List<Widget> tabs = [
    Container(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(post.length, (index) {
            return Column(
              children: [
                PostOverview(
                  post[0]['name'],
                  post[index]['address'],
                  post[index]['title'],
                  post[index]['Content'],
                  post[index]['tag'],
                  post[index]['postImage'],
                  post[0]['avatar'],
                  post[index]['love'],
                  post[index]['commentcount'],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          }),
        ),
      ),
    ),
    IntroductionEventView(),
  ];
  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        new TabController(length: tabs.length, vsync: this);
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverToBoxAdapter(
              child:  EventOverview(widget.eventName, widget.scrAvatar),),
                
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
        child:Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: TabBarView( controller: _tabController, children: tabs),
        ),
      ),
    );
  }
}
