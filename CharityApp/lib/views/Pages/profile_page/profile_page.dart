import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/views/Component/post_overview.dart';
import 'package:flutter/material.dart';

import 'Widgets/profile_overview.dart';

class ProfilePage extends StatefulWidget {
  final List<PostOverview> listPosts;

  ProfilePage({this.listPosts = const []});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ProfileOverView(
              users[0]['name'],
              users[0]['birth'],
              users[0]['decs'],
              users[0]['overview'],
              users[0]['img'],
            ),
          ),
          Divider(thickness: 1.0),
          Column(
            children: List.generate(post.length, (index) {
              return 
                Column(
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
                    SizedBox(height: 10,)
                  ],
                )
              ;
            }),
          ),
        ],
      ),
    );
  }
}
