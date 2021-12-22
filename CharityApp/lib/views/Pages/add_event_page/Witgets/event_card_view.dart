import 'dart:io';
import 'dart:ui';

import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EventCardView extends StatefulWidget {
  final String title;
  final int number;
  final DateTime time;
  const EventCardView(
      {Key? key, required this.title, required this.number, required this.time})
      : super(key: key);

  @override
  _EventCardViewState createState() => _EventCardViewState();
}

class _EventCardViewState extends State<EventCardView> {
  final String image =
      "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80";

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Row(children: [
            Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(image), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: SizedBox(
                    width: 250,
                    child: Text(widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: 'Roboto-Regular.ttf',
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(height: 5),
                RichText(
                    text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: widget.time.hour.toString() +
                          ":" +
                          widget.time.minute.toString(),
                      style: TextStyle(
                        fontFamily: 'Roboto-Regular.ttf',
                        fontSize: 13,
                        color: Colors.red,
                      )),
                  TextSpan(
                    text: ", " +
                        widget.time.day.toString() +
                        "/" +
                        widget.time.month.toString() +
                        "/" +
                        widget.time.year.toString(),
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular.ttf',
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  )
                ]))
              ],
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  "Người tham gia ",
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                      fontFamily: 'Roboto-Regular.ttf',
                      fontSize: 13,
                      color: Colors.grey[600]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(children: [
                  CircleAvatar(
                      backgroundImage: NetworkImage(image), radius: 15),
                  Positioned(
                      left: 10,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(image), radius: 15)),
                  Positioned(
                      left: 20,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(image), radius: 15)),
                  Positioned(
                      left: 30,
                      child: CircleAvatar(
                          backgroundColor: maincolor,
                          child: Text("+" + widget.number.toString()))),
                ]),
              )
            ],
          )
        ],
      ),
    );
  }
}
