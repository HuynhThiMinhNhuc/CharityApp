import 'package:flutter/material.dart';
import 'package:charityapp/views/HomeView/information_profile_view.dart';
import 'package:intl/intl.dart';

class ProfileOverView extends StatefulWidget {
  final String name;
  final DateTime birthday;
  final String description;
  final List<int> number;

  ProfileOverView(this.name, this.birthday, this.description, this.number);

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
        SizedBox(height: 10,),
        Row(
          children: [
            //Avatar widget
            CircleAvatar(
              backgroundImage: AssetImage(
                  'asset/Login.png'), //Image.asset('asset/Login.png', height: 100, width: 100,),
              radius: 40,
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
        Container(
          margin: const EdgeInsets.fromLTRB(0,5,0,5),
          child: RichText(
            text: TextSpan(style: myStyle(), children: <TextSpan>[
              TextSpan(
                  text: 'Họ và tên: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: widget.name),
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0,5,0,5),
          child: RichText(
            text: TextSpan(style: myStyle(), children: <TextSpan>[
              TextSpan(
                  text: 'Ngày sinh: ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: DateFormat("dd/MM/yyyy").format(widget.birthday)),
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0,5,0,5),
          child: Text(
            widget.description,
            style: myStyle(),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => {},
            child: Text('Chỉnh sửa hồ sơ'),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(90, 164, 105, 1.0))),
          ),
        ),
      ],
    );
  }

  TextStyle myStyle() {
    return TextStyle(fontSize: 18, color: Colors.black);
  }
}
