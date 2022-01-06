import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/home_page/form_view.dart';
import 'package:charityapp/views/Pages/profile_page/Widgets/information_profile_view.dart';
import 'package:charityapp/views/Pages/profile_page/profile_other.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

enum mode { Joiner, Pending_approval }

class DetailFormJoinings extends StatefulWidget {
  final UserProfile userProfile;
  final FormRegister formDetail;
  const DetailFormJoinings(
      {Key? key, required this.userProfile, required this.formDetail})
      : super(key: key);

  @override
  _DetailFormJoiningsState createState() => _DetailFormJoiningsState();
}

class _DetailFormJoiningsState extends State<DetailFormJoinings> {
  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 60) / 2;
    BuildContext detailFormContext = context;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundbottomtab,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            "Đang chờ duyệt",
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: JoinerOverview(widget.userProfile,
                      mode.Pending_approval, width, detailFormContext),
                ),
                Divider(
                  color: Colors.black54,
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Câu trả lời form",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                getbody(widget.userProfile)
              ],
            ),
          ),
        ));
  }

  Column JoinerOverview(UserProfile joinerProfile, mode modeJoiner,
      double width, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            //Avatar widget
            InkWell(
              child: Container(
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
                      image: joinerProfile.avatarUri != ""
                          ? NetworkImage(joinerProfile.avatarUri!)
                              as ImageProvider
                          : AssetImage('asset/avatar.png'),
                    ),
                  ),
                ),
              ),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (context) => OverViewUserBloc(),
                              child:
                                  ProfileOtherPage(joinerProfile.id, () => {}),
                            )))
              },
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InformationProfileView(joinerProfile.numberPost, "Bài viết"),
                  InformationProfileView(
                      joinerProfile.numberFollower, "Người theo dõi"),
                  InformationProfileView(
                      joinerProfile.numberFollowing, "Đang theo dõi"),
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
                text: joinerProfile.name,
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
                text: DateFormat("dd/MM/yyyy")
                    .format(joinerProfile.birthDay as DateTime),
              )
            ]),
          ),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Text(
            joinerProfile.description as String,
            style: TextStyle(
                fontSize: 13,
                decoration: TextDecoration.none,
                fontFamily: 'Roboto_Regular',
                color: textcolor),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: modeJoiner == mode.Joiner
              ? ElevatedButton(
                  onPressed: () => {setState(() {})},
                  child: Text(
                    'Loại khỏi sự kiện',
                    style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto_Regular',
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(redcolor)),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width,
                      child: ElevatedButton(
                        onPressed: () => {setState(() {})},
                        child: Text(
                          'Chấp nhận',
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
                    SizedBox(
                      width: width,
                      child: ElevatedButton(
                        onPressed: () => {setState(() {})},
                        child: Text(
                          'Từ chối',
                          style: TextStyle(
                              fontSize: 13,
                              decoration: TextDecoration.none,
                              fontFamily: 'Roboto_Regular',
                              fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(redcolor)),
                      ),
                    )
                  ],
                ),
        ),
      ],
    );
  }

  Widget getbody(UserProfile joiner) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Tên",
              style: TextStyle(
                  fontFamily: 'Roboto_Regular',
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: textcolor),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                fillColor: Color(0xFFF4F4F4),
                filled: true,
                hintText: joiner.name,
                enabled: false,
                contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              ),
            ),
            SizedBox(
              height: 20,
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
              height: 10,
            ),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Color(0xFFF4F4F4),
                  hintText: joiner.phone,
                  enabled: false,
                  contentPadding: EdgeInsets.fromLTRB(5, 0, 5, 0)),
            ),
            SizedBox(
              height: 20,
            ),
            TextInput(
                isEnable: false,
                title:
                    "Bạn nghĩ mình sẽ giúp đỡ công việc tình nguyện này như thế nào?",
                Items: [],
                maxline: 5),
            TextInput(
                isEnable: false,
                title: "Đối nét về bản thân( sở thích, tính cách, tài lẻ...)",
                Items: [],
                maxline: 5),
            TextInput(
                isEnable: false,
                title: "Link Facebook(nếu có)",
                Items: [],
                maxline: 5)
          ],
        ),
      ),
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
