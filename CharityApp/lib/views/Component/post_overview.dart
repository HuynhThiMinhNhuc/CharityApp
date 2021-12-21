import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/home_page/comment_view.dart';
import 'package:charityapp/views/Pages/home_page/event_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'information_creator_post_view.dart';

class PostOverview extends StatefulWidget {
  final Post post;

  PostOverview({required this.post});

  @override
  _PostOverviewState createState() => _PostOverviewState();
}

class _PostOverviewState extends State<PostOverview> {
  bool love = false;
  FaIcon icon = FaIcon(FontAwesomeIcons.heart);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          InformationCreatorPostView(creator: widget.post.creator),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.post.imagesUri[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EventPage(users[0]['img'],
                            post[5]['postImage'], post[1]['title'])));
              },
              child: Text(
                widget.post.title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Roboto_Regular'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
            child: Text(
              widget.post.description,
              style: TextStyle(fontSize: 13, fontFamily: 'Roboto_Regular'),
            ),
          ),
          SizedBox(
            height: 30,
            child: ListView.builder(
              itemBuilder: (_, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: OutlinedButton(
                    onPressed: null,
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0x50979797)),
                    ),
                    child: Text(
                      widget.post.tags[index],
                      style: TextStyle(
                          fontFamily: 'Roboto_Regular',
                          fontSize: 12,
                          color: Color(0xFF455154)),
                    ),
                  ),
                );
              },
              itemCount: widget.post.tags.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Xem bình luận',
                  style: TextStyle(
                    fontFamily: 'Roboto_Regular',
                    fontSize: 11,
                    color: Colors.black45,
                  ),
                ),
                Spacer(),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            icon = love
                                ? FaIcon(
                                    FontAwesomeIcons.heart,
                                    color: Colors.red,
                                  )
                                : FaIcon(FontAwesomeIcons.heart);
                          },
                        );
                      },
                      icon: icon,
                      splashRadius: 20,
                    ),
                    Text(
                      widget.post.numberLike.toString(),
                      style: TextStyle(
                          fontFamily: 'Roboto_Regular',
                          fontSize: 13,
                          color: textcolor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentView(
                                      total: widget.post.numberLike,
                                      islove: true,
                                    )));
                      },
                      icon: FaIcon(FontAwesomeIcons.comment),
                      splashRadius: 20,
                    ),
                    Text(
                      widget.post.numberComment.toString(),
                      style: TextStyle(
                          fontFamily: 'Roboto_Regular',
                          fontSize: 13,
                          color: textcolor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
