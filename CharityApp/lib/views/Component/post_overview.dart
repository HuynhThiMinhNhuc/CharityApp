import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/Homepage/Comment_View.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'information_creator_post_view.dart';

class PostOverview extends StatefulWidget {
  final String nameCreator;
  final String location;
  final String title;
  final String description;
  final List<String> tags;
  final String imageAsset;
  final String avatar;
  final int like;
  final int cmt;

  PostOverview(this.nameCreator, this.location, this.title, this.description,
      this.tags, this.imageAsset, this.avatar, this.like, this.cmt);

  @override
  _PostOverviewState createState() => _PostOverviewState();
}

class _PostOverviewState extends State<PostOverview> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          InformationCreatorPostView(
              widget.nameCreator, widget.location, widget.avatar),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.imageAsset), fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
            child: Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  fontFamily: 'Roboto_Regular'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
            child: Text(
              widget.description,
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
                    ),
                    child: Text(widget.tags[index],
                    style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 12,
                    ),),
                  ),
                );
              },
              itemCount: widget.tags.length,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
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
                        onPressed: null, icon: FaIcon(FontAwesomeIcons.heart)),
                    Text(
                      widget.like.toString(), 
                    style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 13,
                      color: textcolor,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: <Widget>[
                    IconButton(
                        onPressed:() {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                              builder: (context) => comment_view(total: widget.like, islove: true,)
                            )
    );}, icon: FaIcon(FontAwesomeIcons.comment)),
                    Text(
                      widget.cmt.toString(), 
                    style: TextStyle(
                      fontFamily: 'Roboto_Regular',
                      fontSize: 13,
                      color: textcolor,
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
