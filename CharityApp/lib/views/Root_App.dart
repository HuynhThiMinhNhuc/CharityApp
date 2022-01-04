import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/tab_selector.dart';
import 'package:charityapp/views/Pages/friend_page/friend_page.dart';
import 'package:charityapp/views/bloc/searchevent_bloc/bloc/searchevent_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/calendar_page/calendar_page.dart';
import 'Pages/home_page/home_page.dart';
import 'Pages/home_page/search_view.dart';
import 'Pages/profile_page/profile_page.dart';
import 'bloc/tab_bloc/tab.dart';

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
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider(
                          create: (context) => SearcheventBloc(),
                          child: SearchEvent(),
                        )))
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
        )
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
    else if (activateTab == AppTab.profile)
      return ProfilePage();
    else {
      return Text("Fail tab");
    }
  }
}
