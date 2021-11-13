import 'package:charityapp/Constant/cmt_json.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/ButtonCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class comment_view extends StatefulWidget {
  final int total;
  final bool islove;
  const comment_view({Key? key, required this.total, required this.islove})
      : super(key: key);

  @override
  _comment_viewState createState() => _comment_viewState();
}

class _comment_viewState extends State<comment_view> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: textcolor),
        backgroundColor: backgroundbottomtab,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              widget.total.toString(),
              style: TextStyle(
                  fontFamily: 'Roboto_Regular', fontSize: 12, color: textcolor),
            ),
            SizedBox(
              width: 5,
            ),
            IconButton(
                onPressed: () {},
                icon: widget.islove
                    ? FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.red[900],
                      )
                    : FaIcon(FontAwesomeIcons.heart))
          ],
        ),
      ),
      body: getbody(),
    );
  }

  Widget getbody() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
                children: List.generate(cmts.length, (index) {
              return CommentItem(
                  avatar: cmts[index]['avatar'],
                  name: cmts[index]['name'],
                  time: cmts[index]['timeago'],
                  cmt: cmts[index]['comment']);
            })),
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: 60,
            color: backgroundbottomtab,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Viết bình luận",
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(5, 5, 50, 0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: maincolor),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      iconSize: 25,
                      onPressed: null,
                      icon: Icon(
                        Icons.send,
                        color: maincolor,
                      ))
                ],
              ),
            )),
      ],
    );
  }
}

class CommentItem extends StatelessWidget {
  final String avatar;
  final String name;
  final int time;
  final String cmt;

  const CommentItem(
      {Key? key,
      required this.avatar,
      required this.name,
      required this.time,
      required this.cmt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(avatar), fit: BoxFit.cover))),
              SizedBox(
                width: 5,
              ),
              Text(
                name,
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 13,
                    color: textcolor,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                " - " + time.toString() + " tiếng trước",
                style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 12,
                    color: const Color(0xFF838282)),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            cmt,
            textAlign: TextAlign.start,
            style: TextStyle(
                fontFamily: 'Roboto_Regular', fontSize: 14, color: textcolor),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
