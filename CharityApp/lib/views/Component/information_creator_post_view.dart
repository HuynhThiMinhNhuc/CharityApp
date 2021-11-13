import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/ProfileView/profile_page.dart';
import 'package:charityapp/views/Profile.dart';
import 'package:flutter/material.dart';

class InformationCreatorPostView extends StatelessWidget {
  final String avatarAsset;
  final String name;
  final String location;

  InformationCreatorPostView(this.name, this.location, this.avatarAsset);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(this.avatarAsset), fit: BoxFit.cover),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                child: Text(this.name,
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
