import 'package:animations/animations.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/profile_page/edit_profile.dart';
import 'package:charityapp/views/bloc/editprofile_bloc/bloc/editprofile_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_bloc.dart';
import 'package:charityapp/views/bloc/overviewuse_bloc/overviewuser_even.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          height: 10.h,
        ),
        Row(
          children: [
            //Avatar widget
            Container(
              width: 80.h,
              height: 80.h,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: activecolor)),
              child: Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 5.h),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: (widget.userProfile.avatarUri != "" &&
                            widget.userProfile.avatarUri != null)
                        ? NetworkImage(widget.userProfile.avatarUri!)
                            as ImageProvider
                        : AssetImage('asset/avatar.png'),
                  ),
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
                      widget.userProfile.numberFollower, "Theo dõi"),
                  InformationProfileView(
                      widget.userProfile.numberFollowing, "Đang theo dõi"),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
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
          margin: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
          child: RichText(
            text: TextSpan(style: myStyle(), children: <TextSpan>[
              TextSpan(
                text: 'Ngày sinh: ',
                style: myStyle(isBold: true),
              ),
              TextSpan(
                text: widget.userProfile.birthDay != null
                    ? DateFormat("dd/MM/yyyy")
                        .format(widget.userProfile.birthDay as DateTime)
                    : "",
              )
            ]),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 5.h, 0, 10.h),
          child: (widget.userProfile.description != null &&
                  widget.userProfile.description?.length != 0)
              ? Text(
                  widget.userProfile.description as String,
                  style: TextStyle(
                      fontSize: 13,
                      decoration: TextDecoration.none,
                      fontFamily: 'Roboto_Regular',
                      color: textcolor),
                )
              : Container(
                  width: 0,
                ),
        ),
        SizedBox(
          width: double.infinity,
          child: widget.modeProfile == mode.My
              ? OpenContainer(
                  transitionDuration: Duration(seconds: 1),
                  transitionType: ContainerTransitionType.fade,
                  closedBuilder:
                      (BuildContext context, VoidCallback opencontainer) =>
                          ElevatedButton(
                    onPressed: opencontainer,
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
                  ),
                  openBuilder: (BuildContext context, _) => BlocProvider(
                    create: (context) => EditprofileBloc(),
                    child: EditProfile(
                      currentUser: new UserProfile(
                          name: widget.userProfile.name,
                          avatarUri: widget.userProfile.avatarUri,
                          phone: widget.userProfile.phone,
                          email: widget.userProfile.email,
                          birthDayString: widget.userProfile.birthDayString,
                          gender: widget.userProfile.gender,
                          description: widget.userProfile.description,
                          id: widget.userProfile.id),
                      onEditPro: () => widget.overViewUserBloc
                          .add(LoadOverViewUserEvent(widget.userProfile.id)),
                    ),
                  ),
                )
              : widget.modeProfile == mode.Friend
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
                            fontSize: 13.sp,
                            decoration: TextDecoration.none,
                            fontFamily: 'Roboto_Regular',
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(redcolor)),
                    )
                  : widget.modeProfile == mode.Stranger
                      ? ElevatedButton(
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
                                fontSize: 13.sp,
                                decoration: TextDecoration.none,
                                fontFamily: 'Roboto_Regular',
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(90, 164, 105, 1.0))),
                        )
                      : widget.modeProfile == mode.Joiner
                          ? ElevatedButton(
                              onPressed: () => {
                                setState(() {
                                  widget.overViewUserBloc
                                      .add(FollowEvent(widget.userProfile.id));
                                  widget.modeProfile = mode.Friend;
                                })
                              },
                              child: Text(
                                'Loại khỏi sự kiện',
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    decoration: TextDecoration.none,
                                    fontFamily: 'Roboto_Regular',
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(90, 164, 105, 1.0))),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () => {setState(() {})},
                                  child: Text(
                                    'Chấp nhận',
                                    style: TextStyle(
                                        fontSize: 13.sp,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Roboto_Regular',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromRGBO(
                                                  90, 164, 105, 1.0))),
                                ),
                                ElevatedButton(
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
                                )
                              ],
                            ),
        ),
      ],
    );
  }

  TextStyle myStyle({bool isBold = false}) {
    return TextStyle(
        color: textcolor,
        fontSize: 15.sp,
        decoration: TextDecoration.none,
        fontFamily: 'Roboto_Regular',
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal);
  }
}
