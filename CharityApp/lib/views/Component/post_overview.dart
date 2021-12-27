import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/home_page/comment_view.dart';
import 'package:charityapp/views/Pages/home_page/event_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'information_creator_post_view.dart';

class PostOverviewCard extends StatefulWidget {
  final Post post;

  PostOverviewCard({required this.post});

  @override
  _PostOverviewCardState createState() => _PostOverviewCardState();
}

class _PostOverviewCardState extends State<PostOverviewCard> {
  bool love = false;
  late FaIcon icon;

  @override
  void initState() {
    super.initState();
    icon = FaIcon(FontAwesomeIcons.heart);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
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
            if (widget.post.imagesUri.length > 0) Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1593113646773-028c64a8f1b8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
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
                          builder: (context) => EventPage(
                                name: "text",
                                scrAvatar: users[0]['img'],
                                scrBackground: post[5]['postImage'],
                              )));
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
            if (widget.post.tags.length > 0) SizedBox(
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
      ),
    );
  }
}
