import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/event_overview.dart';
import 'package:charityapp/views/Pages/home_page/Witdgets/introduction_eventview.dart';
import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  List<PostOverview> posts;
  String scrAvatar;
  String srcBackground;
  String eventName;

  EventPage(this.scrAvatar, this.srcBackground, this.eventName, this.posts);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              Column(
                children:<Widget>[ 
                  new SliverAppBar(
                  iconTheme: IconThemeData(color: textcolor),
                  backgroundColor: backgroundbottomtab,
                  centerTitle: true,
                  title:Text(
                    "Sự kiện",
                    style: TextStyle(
                        color: textcolor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  floating: true,
                  pinned: true,
                  snap: true,
                ),
               EventOverview(widget.eventName, widget.scrAvatar),
                SizedBox(
                  height: 10,
                ),]
              )
            ];
            
          },
          body: Scaffold(
              backgroundColor: Colors.white,
               body: SafeArea(
                  child: Column(children: [
               
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Divider(
                    color: const Color(0xFFDDDDDD),
                  ),
                ),
                SizedBox(
                  height: 50,
                  child: TabBar(
                      labelColor: maincolor,
                      indicatorColor: maincolor,
                      unselectedLabelColor: Color(0xff757070),
                      tabs: [
                        Tab(text: 'Trang chủ'),
                        Tab(
                          text: 'Giới thiệu',
                        ),
                      ]),
                ),
                Expanded(
                    child: TabBarView(
                  children: tabs,
                 
                ))
              ]))),
        ),
      ),
    );
  }

  Widget getTabbar() {
    return Column(
      children: [
        SizedBox(
          child: AppBar(
            bottom: TabBar(
              labelColor: maincolor,
              indicatorColor: maincolor,
              tabs: [
                Tab(
                  text: "Trang chủ",
                ),
                Tab(
                  text: "Giới thiệu",
                ),
              ],
            ),
          ),
        ),
        Expanded(child: TabBarView(children: tabs))
      ],
    );
  }
}
