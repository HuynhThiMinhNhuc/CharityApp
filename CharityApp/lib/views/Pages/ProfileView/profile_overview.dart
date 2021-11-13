import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/ActiveItem.dart';
import 'package:charityapp/views/Pages/EditProfile.dart';
import 'package:charityapp/views/Pages/ProfileView/information_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileOverView extends StatefulWidget {
  final String name;
  final DateTime birthday;
  final String description;
  final List<int> number;
  final String img;

  ProfileOverView(
      this.name, this.birthday, this.description, this.number, this.img);

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
                      image: NetworkImage(widget.img), fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InformationProfileView(widget.number[0], "Bài viết"),
                  InformationProfileView(widget.number[1], "Người theo dõi"),
                  InformationProfileView(widget.number[2], "Đang theo dõi"),
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
                text: widget.name,
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
                text: DateFormat("dd/MM/yyyy").format(widget.birthday),
              )
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Text(
            widget.description,
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
                  MaterialPageRoute(builder: (context) => editprofile()))
            },
            child: Text(
              'Theo dõi',
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
