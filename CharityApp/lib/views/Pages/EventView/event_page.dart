import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/EventView/event_overview.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            EventOverview(widget.eventName, widget.scrAvatar),
          ],
        ),
      ),
    );
  }
}
