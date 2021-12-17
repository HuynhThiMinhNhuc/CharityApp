import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Component/tab_selector.dart';
import 'package:charityapp/views/Pages/add_event_page/add_event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Pages/calendar_page/calendar_page.dart';
import 'Pages/home_page/home_page.dart';
import 'bloc/tab_bloc/tab.dart';

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
              return BlocProvider.of<TabBloc>(context)
                  .add(UpdateTab(newActiveTab: tab));
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
        else if (activateTab == AppTab.addpost)
          createPostAppbar()
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

  AppBar createPostAppbar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundbottomtab,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      title: Text(
        "Tạo sự kiện",
        style: TextStyle(
            color: textcolor,
            fontFamily: 'Roboto_Regular',
            fontWeight: FontWeight.bold),
      ),
      actions: [
        GestureDetector(
          child: Text(
            "Đăng",
            style: TextStyle(
                color: textcolor,
                fontFamily: 'Roboto_Regular',
                fontWeight: FontWeight.bold),
          ),
          onTap: () {},
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

  // List<Widget> Pages = [
  //   HomePage(),
  //   CalendarPage(),
  //   Center(
  //     child: Text(
  //       'Newpage',
  //       style: TextStyle(
  //           color: textcolor,
  //           fontFamily: 'Roboto_Regular',
  //           fontWeight: FontWeight.bold),
  //     ),
  //   ),
  //   Center(
  //     child: Text(
  //       'Newpage',
  //       style: TextStyle(
  //           color: textcolor,
  //           fontFamily: 'Roboto_Regular',
  //           fontWeight: FontWeight.bold),
  //     ),
  //   ),

  //   // EventPage(users[0]['img'], post[5]['postImage'], post[1]['title']),
  //   //  ProfilePage(userprofile: GetIt.instance.get<Authenticator>().currentUser, posts: null),
  // ];

  // Widget getbody() {
  //   return IndexedStack(
  //     index: page_index,
  //     children: Pages,
  //   );
  // }

  Widget getbody(AppTab activateTab) {
    if (activateTab == AppTab.home)
      return HomePage();
    else if (activateTab == AppTab.calendar)
      return CalendarPage();
    else if (activateTab == AppTab.addpost)
      return AddEventPage();
    // else if (activateTab == AppTab.friend)
    // return EventPage(users[0]['img'], post[5]['postImage'], post[1]['title']);
    // else if (activateTab == AppTab.profile)
    // return ProfilePage(userprofile: GetIt.instance.get<Authenticator>().currentUser, posts: null);
    else {
      return Text("Fail tab");
    }
  }

  // Widget getBottom() {
  //   List BottomItem = [
  //     page_index == 0
  //         ? "asset/Icon/HomeFullIcon.png"
  //         : "asset/Icon/HomeIcon.png",
  //     page_index == 1
  //         ? "asset/Icon/CalendarFullIcon.png"
  //         : "asset/Icon/CalendarIcon.png",
  //     page_index == 2 ? "asset/Icon/NewFullIcon.png" : "asset/Icon/NewIcon.png",
  //     page_index == 3
  //         ? "asset/Icon/FriendFullIcon.png"
  //         : "asset/Icon/FriendIcon.png",
  //     page_index == 4
  //         ? "asset/Icon/ProfileFullIcon.png"
  //         : "asset/Icon/ProfileIcon.png"
  //   ];

  //   return Container(
  //       height: 60,
  //       width: double.infinity,
  //       decoration: BoxDecoration(color: backgroundbottomtab),
  //       child: Padding(
  //         padding:
  //             const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 20),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: List.generate(BottomItem.length, (index) {
  //             return InkWell(
  //                 onTap: () {
  //                   TabSelected(index);
  //                 },
  //                 child: (Image.asset(BottomItem[index])));
  //           }),
  //         ),
  //       ));
  // }

  // TabSelected(index) {
  //   setState(() {
  //     page_index = index;
  //   });
  // }
}
