import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/tab_selector.dart';
import 'package:charityapp/views/Login/login_view.dart';
import 'package:charityapp/views/Pages/friend_page/friend_page.dart';
import 'package:charityapp/views/bloc/searchevent_bloc/bloc/searchevent_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';

import 'Pages/calendar_page/calendar_page.dart';
import 'Pages/home_page/home_page.dart';
import 'Pages/home_page/search_view.dart';
import 'Pages/profile_page/profile_page.dart';
import 'bloc/signin_bloc/signin_bloc.dart';
import 'bloc/tab_bloc/tab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef onAddPostCallback = Function(Post post);

class RootApp extends StatelessWidget {
  var context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activateTab) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: getappbar(activateTab)),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: getbody(context, activateTab),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activateTab,
            onTabSelected: (tab) {
              if (tab == AppTab.addObject) {
              } else {
                BlocProvider.of<TabBloc>(context)
                    .add(UpdateTab(newActiveTab: tab));
              }
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: SpeedDial(
              backgroundColor: Colors.black,
              animatedIcon: AnimatedIcons.add_event,
              animatedIconTheme: IconThemeData(size: 25.h),
              closeManually: false,
              shape: CircleBorder(),
              children: [
                SpeedDialChild(
                    child: Icon(Icons.post_add_rounded, color: Colors.white),
                    backgroundColor: maincolor,
                    label: "Bài đăng",
                    onTap: () => {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.addPost,
                          )
                        }),
                SpeedDialChild(
                    child: Icon(Icons.event_available_outlined,
                        color: Colors.white),
                    backgroundColor: Colors.red[400],
                    label: "Sự kiện",
                    onTap: () => {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.addEvent,
                          )
                        }),
              ],
            ),
            onPressed: null,
          ),
        );
      },
    );
  }

  Widget getappbar(AppTab activateTab) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (activateTab == AppTab.home)
          homeAppBar()
        else if (activateTab == AppTab.calendar)
          calendarAppbar()
        else if (activateTab == AppTab.friend)
          friendAppbar()
        else if (activateTab == AppTab.profile)
          profileAppbar()
        else
          Text("Fail tab"),
      ],
    );
  }

  AppBar profileAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundbottomtab,
      title: Text("Hồ sơ của bạn",
          style: TextStyle(
              color: textcolor,
              fontFamily: 'Roboto_Regular',
              fontWeight: FontWeight.bold)),
    );
  }

  AppBar friendAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundbottomtab,
      title: Text("Bạn bè", style: kText24BoldBlack),
    );
  }

  AppBar createPostAppbar({Function? onClickSubmit, Function? onClickBack}) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundbottomtab,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: onClickBack?.call(),
      ),
      title: Text(
        "Tạo sự kiện",
        style: kText24BoldBlack,
      ),
      actions: [
        TextButton(
          onPressed: onClickSubmit?.call(),
          child: Text(
            "Đăng",
            style: kText24BoldBlack,
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
      ],
    );
  }

  AppBar calendarAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundbottomtab,
      title: Text(
        "Sự kiện",
        style: kText24BoldBlack,
      ),
    );
  }

  AppBar homeAppBar({Function? onClickSearch, Function? onClickNotification}) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 100,
      backgroundColor: backgroundbottomtab,
      titleSpacing: 0,
      leading: Text(
        ' Meer',
        style: TextStyle(
            color: maincolor,
            fontFamily: 'Redressed_Regular',
            fontSize: 35,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => SearcheventBloc(),
                          child: SearchEvent(),
                        )));
          },
          icon: const Icon(Icons.search, color: textcolor),
          tooltip: "Tìm kiếm",
        ),
        IconButton(
          onPressed: onClickNotification?.call(),
          icon: const Icon(
            Icons.notifications_active,
            color: textcolor,
          ),
          tooltip: "Xem thông báo",
        ),
        PopupMenuButton(
          icon: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            PopupMenuItem(
              child: InkWell(
                onTap: () async {
                  String id = "";
                  await FirebaseFirestore.instance
                      .collection("activeusers")
                      .where("id",
                          isEqualTo: (GetIt.instance
                              .get<Authenticator>()
                              .userProfile
                              .id))
                      .get()
                      .then((value) => id = value.docs[0].id);
                  await FirebaseFirestore.instance
                      .collection("activeusers")
                      .doc(id)
                      .delete();
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (_) => SigninBloc(),
                          child: Login(),
                        ),
                      ),
                      (route) => false);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: redcolor,
                  ),
                  title: Text('Đăng xuất'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getbody(BuildContext context, AppTab activateTab) {
    if (activateTab == AppTab.home) {
      return HomePage()..loadPage(context);
    } else if (activateTab == AppTab.calendar)
      return CalendarPage();
    // else if (activateTab == AppTab.addpost)
    //   return AddEventPage();
    else if (activateTab == AppTab.friend)
      return FriendPage();
    else if (activateTab == AppTab.profile) {
      final creator = Authenticator.profile;
      return ProfilePage(creator: creator);
    } else {
      return Text("Fail tab");
    }
  }
}
