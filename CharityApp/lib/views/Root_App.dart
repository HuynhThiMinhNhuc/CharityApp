import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Component/tab_selector.dart';
import 'package:charityapp/views/Pages/friend_page/friend_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'Pages/calendar_page/calendar_page.dart';
import 'Pages/home_page/home_page.dart';
import 'Pages/profile_page/profile_page.dart';
import 'bloc/tab_bloc/tab.dart';

typedef onAddPostCallback = Function(Post post);

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activateTab) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: getappbar(activateTab)),
          body: getbody(activateTab),
          bottomNavigationBar: TabSelector(
            activeTab: activateTab,
            onTabSelected: (tab) {
              if (tab == AppTab.addpost) {
                Navigator.pushNamed(
                  context,
                  AppRoutes.addPost,
                );
              } else {
                BlocProvider.of<TabBloc>(context)
                    .add(UpdateTab(newActiveTab: tab));
              }
            },
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
        // else if (activateTab == AppTab.addpost)
        //   createPostAppbar()
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
      title: Text("Người theo dõi",
          style: TextStyle(
              color: textcolor,
              fontFamily: 'Roboto_Regular',
              fontWeight: FontWeight.bold)),
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
        style: TextStyle(
            color: textcolor,
            fontFamily: 'Roboto_Regular',
            fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: onClickSubmit?.call(),
          child: Text(
            "Đăng",
            style: TextStyle(
                color: textcolor,
                fontFamily: 'Roboto_Regular',
                fontWeight: FontWeight.bold),
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
        style: TextStyle(
            color: textcolor,
            fontFamily: 'Roboto_Regular',
            fontWeight: FontWeight.bold),
      ),
    );
  }

  AppBar homeAppBar({Function? onClickSearch, Function? onClickNotification}) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      backgroundColor: backgroundbottomtab,
      titleSpacing: 0,
      leading: Text(
        'Meer',
        style: TextStyle(
            color: maincolor,
            fontFamily: 'Redressed_Regular',
            fontSize: 35,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none),
      ),
      actions: [
        IconButton(
          onPressed: onClickSearch?.call(),
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
        )
      ],
    );
  }

  Widget getbody(AppTab activateTab) {
    if (activateTab == AppTab.home)
      return HomePage(
        needReload: true,
      );
    else if (activateTab == AppTab.calendar)
      return CalendarPage();
    // else if (activateTab == AppTab.addpost)
    //   return AddEventPage();
    else if (activateTab == AppTab.friend)
      return FriendPage();
    else if (activateTab == AppTab.profile)
      return ProfilePage();
    else {
      return Text("Fail tab");
    }
  }
}
