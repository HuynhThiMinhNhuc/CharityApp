import 'package:flutter/material.dart';
import 'package:charityapp/views/HomeView/informationprofileview.dart';
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
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: Text(
            "Hồ sơ của bạn",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Avatar widget
            InformationProfileView(widget.number[0], "Bài viết"),
            InformationProfileView(widget.number[1], "Người theo dõi"),
            InformationProfileView(widget.number[2], "Đang theo dõi"),
          ],
        ),
        RichText(
          text: TextSpan(style: myStyle(), children: <TextSpan>[
            TextSpan(
                text: 'Họ và tên: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: widget.name),
          ]),
        ),
        RichText(
          text: TextSpan(style: myStyle(), children: <TextSpan>[
            TextSpan(
                text: 'Ngày sinh: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: DateFormat("dd/MM/yyyy").format(widget.birthday)),
          ]),
        ),
        Text(
          widget.description,
          style: myStyle(),
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => {},
            child: Text('Chỉnh sửa hồ sơ'),
          ),
        ),
        Divider(thickness: 1.0, color: Color.fromRGBO(60, 60, 67, 1.0)),
      ],
    );
  }

  TextStyle myStyle() {
    return TextStyle(fontSize: 20, color: Colors.black);
  }
}
