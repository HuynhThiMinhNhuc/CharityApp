import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/EventView/event_overview.dart';
import 'package:charityapp/views/Pages/Homepage/IntroduceEvent_View.dart';
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
    introduceeventview(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            body: SafeArea(
                child: Column(children: [
          EventOverview(widget.eventName, widget.scrAvatar),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Divider(
              color: const Color(0xFFDDDDDD),
            ),
          ),
          SizedBox(
            height: 50,
            child:
                TabBar(labelColor: maincolor, indicatorColor: maincolor, tabs: [
              Tab(text: 'Trang chủ'),
              Tab(
                text: 'Giới thiệu',
              ),
              Tab(
                text: 'Hình ảnh',
              ),
            ]),
          ),
          Expanded(
              child: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Muốn biết thêm về sự kiện?",
                    style: TextStyle(
                        fontFamily: 'Roboto_Regular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textcolor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tham gia ngay",
                    style: TextStyle(
                        fontFamily: 'Roboto_Regular',
                        fontSize: 16,
                        color: textcolor),
                  ),
                ],
              ),
            ),
            Center(child: Text("Giới thiệu")),
            Center(child: Text("Hình ảnh")),
          ]))
        ]))));
  }
}
