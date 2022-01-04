import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/custom_btn.dart';
import 'package:charityapp/views/bloc/activeuser_bloc/activeuser_bloc.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/friend_bloc/friend_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/tab_bloc/tab_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Root_App.dart';

class ThanhYouPage extends StatefulWidget {
  final String name;
  final String event;
  final String avataruri;
  const ThanhYouPage({Key? key, required this.avataruri, required this.name, required this.event}) : super(key: key);

  @override
  _ThanhYouPage createState() => _ThanhYouPage();
}

class _ThanhYouPage extends State<ThanhYouPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 132,
                      height: 142,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                                "asset/imagesample/ImageInApp/heartThanks.png")),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Cảm ơn",
                        style: TextStyle(
                          fontFamily: "Redressed-Regular.ttf",
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text("vì form đăng kí của bạn",
                        style: TextStyle(
                          fontFamily: "Roboto-Regular.ttf",
                          fontSize: 15,
                          color: notetextcolor,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 138,
                      height: 138,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(colors: activecolor)),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Container(
                          width: 138,
                          height: 138,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            image: DecorationImage(
                                image: widget.avataruri == ""
                                    ? AssetImage('asset/avatar.png')
                                        as ImageProvider
                                    : NetworkImage(widget.avataruri),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.name,
                        style: TextStyle(
                          fontFamily: "Roboto-Regular.ttf",
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Yêu cầu của bạn đã được gửi đến chủ sự kiện:",
                        style: TextStyle(
                          fontFamily: "Roboto-Regular.ttf",
                          fontSize: 15,
                          color: notetextcolor,
                        )),
                    SizedBox(
                      height: 15,
                    ),
                    Text(widget.event,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Roboto-Regular.ttf",
                            fontSize: 22,
                            fontWeight: FontWeight.w600)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: CustomButton(
                          onPressed: () => {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MultiBlocProvider(
                                            providers: [
                                              BlocProvider<TabBloc>(
                                                create: (context) => TabBloc(),
                                              ),
                                              BlocProvider<FriendBloc>(
                                                create: (context) =>
                                                    FriendBloc(),
                                              ),
                                              BlocProvider<EditprofileBloc>(
                                                create: (context) =>
                                                    EditprofileBloc(),
                                              ),
                                              BlocProvider<OverViewUserBloc>(
                                                create: (context) =>
                                                    OverViewUserBloc(),
                                              ),
                                              BlocProvider<ActiveuserBloc>(
                                                create: (context) =>
                                                    ActiveuserBloc(),
                                              ),
                                            ],
                                            child: RootApp(
                                            ),
                                          )),
                                  (route) => false,
                                )
                              },
                          textInput: ("Trang chủ")),
                    )
                  ]),
            ),
          ),
        ));
  }
}
