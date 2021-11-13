import 'package:charityapp/Constant/post_jason.dart';
import 'package:charityapp/Constant/user_json.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/Calendarpage/Calendar_page.dart';
import 'package:charityapp/views/Pages/EventView/event_page.dart';
import 'package:charityapp/views/Pages/ProfileView/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'Pages/Homepage/Home_Page.dart';

class root_app extends StatefulWidget {
  const root_app({Key? key}) : super(key: key);

  @override
  _root_appState createState() => _root_appState();
}

class _root_appState extends State<root_app> {
  int page_index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80), child: getappbar()),
      body: getbody(),
      bottomNavigationBar: getBottom(),
    );
  }

  Widget getappbar() {
    if (page_index == 0)
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          (AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: backgroundbottomtab,
            title: Row(
              children: <Widget>[
                Text(
                  'Meer',
                  style: TextStyle(
                      color: maincolor,
                      fontFamily: 'Redressed_Regular',
                      fontSize: 35,
                      fontWeight: FontWeight.normal,
                      decoration: TextDecoration.none),
                ),
                Spacer(),
                IconButton(
                  onPressed: null,
                  icon: const Icon(Icons.search, color: textcolor),
                  tooltip: "Tìm kiếm",
                ),
                IconButton(
                  onPressed: null,
                  icon: const Icon(
                    Icons.notifications_active,
                    color: textcolor,
                  ),
                  tooltip: "Tìm kiếm",
                )
              ],
            ),
          )),
        ],
      );
    else if (page_index == 1)
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppBar(
            centerTitle: true,
            backgroundColor: backgroundbottomtab,
            title: Text(
              "Sự kiện",
              style: TextStyle(
                  color: textcolor,
                  fontFamily: 'Roboto_Regular',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    else if (page_index == 2)
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppBar(
            centerTitle: true,
            backgroundColor: backgroundbottomtab,
            title: Text("Tạo bài viết",
                style: TextStyle(
                    color: textcolor,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.bold)),
          ),
        ],
      );
    else if (page_index == 3)
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppBar(
            centerTitle: true,
            backgroundColor: backgroundbottomtab,
            title: Text("Người theo dõi",
                style: TextStyle(
                    color: textcolor,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.bold)),
          ),
        ],
      );
    else
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppBar(
            centerTitle: true,
            backgroundColor: backgroundbottomtab,
            title: Text("Hồ sơ của bạn",
                style: TextStyle(
                    color: textcolor,
                    fontFamily: 'Roboto_Regular',
                    fontWeight: FontWeight.bold)),
          ),
        ],
      );
  }

  List<Widget> Pages = [
    home_page(),
    calendar_page(),
    Center(
      child: Text(
        'Newpage',
        style: TextStyle(
            color: textcolor,
            fontFamily: 'Roboto_Regular',
            fontWeight: FontWeight.bold),
      ),
    ),
    // Center(
    //   child: Text(
    //     'Friendpage',
    //     style: TextStyle(
    //         color: textcolor,
    //         fontFamily: 'Roboto_Regular',
    //         fontWeight: FontWeight.bold),
    //   ),
    // ),
    //Test EventPage
    EventPage(users[0]['img'], post[5]['postImage'], post[1]['title'], []),
    ProfilePage(),
  ];
  Widget getbody() {
    return IndexedStack(
      index: page_index,
      children: Pages,
    );
  }

  Widget getBottom() {
    List BottomItem = [
      page_index == 0
          ? "asset/Icon/HomeFullIcon.png"
          : "asset/Icon/HomeIcon.png",
      page_index == 1
          ? "asset/Icon/CalendarFullIcon.png"
          : "asset/Icon/CalendarIcon.png",
      page_index == 2 ? "asset/Icon/NewFullIcon.png" : "asset/Icon/NewIcon.png",
      page_index == 3
          ? "asset/Icon/FriendFullIcon.png"
          : "asset/Icon/FriendIcon.png",
      page_index == 4
          ? "asset/Icon/ProfileFullIcon.png"
          : "asset/Icon/ProfileIcon.png"
    ];

    return Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(color: backgroundbottomtab),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(BottomItem.length, (index) {
              return InkWell(
                  onTap: () {
                    TabSelected(index);
                  },
                  child: (Image.asset(BottomItem[index])));
            }),
          ),
        ));
  }

  TabSelected(index) {
    setState(() {
      page_index = index;
    });
  }
}
