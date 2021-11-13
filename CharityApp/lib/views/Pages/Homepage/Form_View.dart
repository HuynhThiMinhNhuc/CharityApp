import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/main.dart';
import 'package:charityapp/views/Component/ButtonCustom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class form_view extends StatefulWidget {
  final String username;
  final String userphone;
  const form_view({Key? key, required this.username, required this.userphone})
      : super(key: key);

  @override
  _form_viewState createState() => _form_viewState();
}

class _form_viewState extends State<form_view> {
  List<String> Items = [
    "Email",
    "Bạn nghĩ mình sẽ giúp đỡ công việc tình nguyện này như thế nào?",
    "Đối nét về bản thân( sở thích, tính cách, tài lẻ...)",
    "Link Facebook(nếu có)",
  ];
  List<int> maxlines = [1, 5, 5, 2];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: textcolor),
          title: Text(
            "Form đăng kí",
            style: TextStyle(
                fontFamily: 'Roboto_Regular',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textcolor),
          ),
          backgroundColor: backgroundbottomtab,
        ),
        body: getbody(),
        bottomNavigationBar: Container(
            height: 60,
            color: backgroundbottomtab,
            alignment: Alignment.center,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child:
                    CustomButton(onPressed: () => {}, textInput: 'Đăng ký'))));
  }

  Widget getbody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              post[0]['title'],
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Tên",
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: widget.username,
                enabled: false,
                contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Số điện thoại",
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: widget.userphone,
                  enabled: false,
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
                children: List.generate(Items.length, (index) {
              return (TextInput(
                Items: [],
                title: Items[index],
                maxline: maxlines[index],
              ));
            }))
          ],
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final String title;
  final int maxline;
  const TextInput(
      {Key? key,
      required this.title,
      required this.Items,
      required this.maxline})
      : super(key: key);

  final List<String> Items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontFamily: 'Roboto_Regular',
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: textcolor),
        ),
        SizedBox(
          height: 5,
        ),
        Theme(
          data: ThemeData(
            primaryColor: maincolor,
            primaryColorDark: Colors.red,
          ),
          child: TextField(
            maxLines: maxline,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: maincolor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
