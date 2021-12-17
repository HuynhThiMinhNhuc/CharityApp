import 'dart:typed_data';

import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/profile_page/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'information_profile_view.dart';

class ProfileOverView extends StatefulWidget {
  UserProfile userProfile;

  ProfileOverView( this.userProfile);

  @override
  _ProfileOverViewState createState() => _ProfileOverViewState();
}

class _ProfileOverViewState extends State<ProfileOverView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   alignment: Alignment.center,
        //   padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
        //   child: Text(
        //     "Hồ sơ của bạn",
        //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        //   ),
        // ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            //Avatar widget
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: activecolor)),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.memory(widget.userProfile.avatar as Uint8List) as ImageProvider),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InformationProfileView(widget.userProfile.numberPost, "Bài viết"),
                  InformationProfileView(widget.userProfile.numberFollower, "Người theo dõi"),
                  InformationProfileView(widget.userProfile.numberFollowing, "Đang theo dõi"),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: RichText(
            text: TextSpan(style: myStyle(), children: <TextSpan>[
              TextSpan(
                text: 'Họ và tên: ',
                style: myStyle(isBold: true),
              ),
              TextSpan(
                text: widget.userProfile.name,
              ),
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: RichText(
            text: TextSpan(style: myStyle(), children: <TextSpan>[
              TextSpan(
                text: 'Ngày sinh: ',
                style: myStyle(isBold: true),
              ),
              TextSpan(
                text: DateFormat("dd/MM/yyyy").format(widget.userProfile.birthDay as DateTime),
              )
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Text(
            widget.userProfile.description as String,
            style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto_Regular',
                color: textcolor),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()))
            },
            child: Text(
              'Chỉnh sửa hồ sơ',
              style: TextStyle(
                  fontSize: 13,
                  decoration: TextDecoration.none,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.bold),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(90, 164, 105, 1.0))),
          ),
        ),
      ],
    );
  }

  TextStyle myStyle({bool isBold = false}) {
    return TextStyle(
        color: textcolor,
        fontSize: 15,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto_Regular',
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal);
  }
}
