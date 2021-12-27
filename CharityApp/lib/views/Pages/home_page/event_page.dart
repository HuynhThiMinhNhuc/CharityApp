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
  final String? scrAvatar;
  final String? srcBackground;
  final String name;
  final List<Post> posts;

  EventPage({this.scrAvatar, this.srcBackground, required this.name, scrBackground, this.posts = const[]});

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
    List<Widget> tabs = [
      Container(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.posts.length,
            itemBuilder: (BuildContext context, int index) {
              return PostOverviewCard(post: widget.posts[index]);
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
                child: EventOverviewCard(widget.name, widget.scrAvatar),
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
