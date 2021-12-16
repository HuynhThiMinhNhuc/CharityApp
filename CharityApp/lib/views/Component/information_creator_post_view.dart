import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Pages/profile_page/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class InformationCreatorPostView extends StatelessWidget {
  final UserOverview creator;
  final String location;

  InformationCreatorPostView({required this.creator, this.location = ''});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: MemoryImage(this.creator.avatar!), fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => ProfilePage(userprofile: , posts: null)));
                },
                child: Text(this.creator.name,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto_Regular',
                        color: textcolor)),
              ),
              SizedBox(
                height: 2,
              ),
              Text(this.location,
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto_Regular',
                      color: textcolor)),
            ],
          )
        ],
      ),
    );
  }
}
