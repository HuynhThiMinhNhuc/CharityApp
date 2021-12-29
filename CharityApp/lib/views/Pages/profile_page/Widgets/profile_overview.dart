import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/profile_page/edit_profile.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:flutter/material.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../profile_page.dart';
import 'information_profile_view.dart';

class ProfileOverView extends StatefulWidget {
  UserProfile userProfile;
  mode modeProfile;
  OverViewUserBloc overViewUserBloc;
  ProfileOverView(this.userProfile, this.modeProfile, this.overViewUserBloc);

  @override
  _ProfileOverViewState createState() => _ProfileOverViewState();
}

class _ProfileOverViewState extends State<ProfileOverView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80")),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InformationProfileView(
                      widget.userProfile.numberPost, "Bài viết"),
                  InformationProfileView(
                      widget.userProfile.numberFollower, "Người theo dõi"),
                  InformationProfileView(
                      widget.userProfile.numberFollowing, "Đang theo dõi"),
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
                text: DateFormat("dd/MM/yyyy")
                    .format(widget.userProfile.birthDay as DateTime),
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
          child:  widget.modeProfile == mode.My?
          ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                                  create: (context) => EditprofileBloc(),
                                  child: EditProfile(
                                    currentUser: widget.userProfile,
                                    onEditPro: () => 
                                    widget.overViewUserBloc
                                        .add(LoadOverViewUserEvent(
                                            widget.userProfile.id)),
                                  ),
                                )))},
                    child: Text(
                    'Chỉnh sửa hồ sơ',
                    style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto_Regular',
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(maincolor)),
          ):
          widget.modeProfile == mode.Friend
              ? ElevatedButton(
                  onPressed: () => {
                    setState(() {
                      widget.overViewUserBloc
                          .add(UnFollowEvent(widget.userProfile.id));
                      widget.modeProfile = mode.Stranger;
                    })
                  },
                  child: Text(
                    'Bỏ theo dõi',
                    style: TextStyle(
                        fontSize: 13,
                        decoration: TextDecoration.none,
                        fontFamily: 'Roboto_Regular',
                        fontWeight: FontWeight.bold),
                  ),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(redcolor)),
                )
              : ElevatedButton(
                  onPressed: () => {
                    setState(() {
                      widget.overViewUserBloc
                          .add(FollowEvent(widget.userProfile.id));
                      widget.modeProfile = mode.Friend;
                    })
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
