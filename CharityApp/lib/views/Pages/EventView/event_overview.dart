import 'package:charityapp/Constant/active_json.dart';
import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/ActiveItem.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:flutter/material.dart';

class EventOverview extends StatefulWidget {
  String eventName;
  String scrAvatar;
  List<PostOverview> posts;

  EventOverview(this.eventName, this.scrAvatar, {this.posts = const []});

  @override
  _EventOverviewState createState() => _EventOverviewState();
}

class _EventOverviewState extends State<EventOverview> {
  int _numberPaticaipant = 10;
  int _numberPost = 8;

  get numberPaticipant => _numberPaticaipant;
  get numberPost => _numberPost;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        AspectRatio(
          aspectRatio: 7 / 3,
          child: Image.network(
            post[0]['postImage'],
            fit: BoxFit.fitWidth,
            alignment: Alignment(0, -1),
          ),
        ),
        Positioned(
          bottom: -130,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: activecolor),
                      ),
                      child: Container(
                        // width: 30,
                        // height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 5),
                          image: DecorationImage(
                            alignment: Alignment(0, -0.8),
                              image: NetworkImage(widget.scrAvatar),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        widget.eventName,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconOverview(Icons.people, this.numberPaticipant),
                    SizedBox(width: 15),
                    IconOverview(Icons.post_add, this.numberPost),
                    SizedBox(width: 20),
                    ElevatedButton(
                      child: Text("Hủy tham gia"),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                              Color.fromRGBO(211, 93, 110, 1.0)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  side: BorderSide(
                                      color:
                                          Color.fromRGBO(211, 93, 110, 1.0)))),
                          textStyle: MaterialStateProperty.all(
                            TextStyle(
                              fontSize: 16,
                            ),
                          )),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget IconOverview(IconData icon, int number) {
    return Row(
      children: [
        CircleAvatar(
          child: Icon(icon),
          radius: 10,
          backgroundColor: Color.fromRGBO(90, 164, 105, 1.0),
        ),
        SizedBox(width: 5),
        Text(number.toString()),
      ],
    );
  }
}
