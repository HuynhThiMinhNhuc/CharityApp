import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:charityapp/views/Pages/home_page/form_view.dart';
import 'package:flutter/material.dart';

class EventOverviewCard extends StatefulWidget {
  final String eventName;
  final String? scrAvatar;
  List<PostOverviewCard> posts;

  EventOverviewCard(this.eventName, this.scrAvatar, {this.posts = const []});

  @override
  _EventOverviewCardState createState() => _EventOverviewCardState();
}

class _EventOverviewCardState extends State<EventOverviewCard> {
  int _numberPaticaipant = 10;
  int _numberPost = 8;

  get numberPaticipant => _numberPaticaipant;
  get numberPost => _numberPost;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        children: [
          Stack(clipBehavior: Clip.none, children: [
            Container(
              height: 210,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(post[0]['postImage']),
                    fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: -80,
              left: 5,
              child: Row(
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
                      width: 86,
                      height: 86,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        image: DecorationImage(
                            alignment: Alignment(0, -0.8),
                            image: NetworkImage(widget.scrAvatar ?? post[0]['avatar']),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: c_width - 110,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.eventName,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'Roboto_Regular',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textcolor),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
          SizedBox(height: 80),
          Row(
            children: [
              SizedBox(width: 100),
              IconOverview(Icons.people, this.numberPaticipant),
              IconOverview(Icons.post_add, this.numberPost),
              SizedBox(width: 0),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FormView(
                                username: users[0]['name'],
                                userphone: users[0]['phone'])));
                  },
                  child: Text(
                    "Tham gia",
                    style: TextStyle(
                        fontFamily: 'Roboto_Regular',
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    fixedSize: Size(150, 30),
                    primary: maincolor,
                  ))
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 0),
            child: Divider(
              color: const Color(0xFFDDDDDD),
            ),
          ),
        ],
      ),
    );
  }

  Widget IconOverview(IconData icon, int number) {
    return Row(
      children: [
        Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: maincolor,
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 5),
        Text(
          number.toString(),
          style: TextStyle(
              fontFamily: 'Roboto_Regular',
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: textcolor),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
