import 'package:charityapp/Config/colorconfig.dart';
import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabSelector extends StatefulWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  State<TabSelector> createState() => _TabSelectorState();
}

class _TabSelectorState extends State<TabSelector> {
  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 4.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home,
              color: _selectedTab == 0 ? cwColorMain : cwColorBlackIcon,
              size: 23.w,
            ),
            tooltip: "Trang chủ",
            onPressed: () {
              widget.onTabSelected(AppTab.values[0]);
              _selectedTab = 0;
            },
          ),
          IconButton(
            icon: Icon(
              Icons.calendar_today_rounded,
              color: _selectedTab == 1 ? cwColorMain : cwColorBlackIcon,
              size: 22.w,
            ),
            tooltip: "Lịch",
            onPressed: () {
              widget.onTabSelected(AppTab.values[1]);
              _selectedTab = 1;
            },
          ),
          SizedBox(width: 24.w),
          IconButton(
            icon: Icon(
              Icons.people,
              color: _selectedTab == 3 ? cwColorMain : cwColorBlackIcon,
              size: 23.w,
            ),
            tooltip: "Bạn bè",
            onPressed: () {
              widget.onTabSelected(AppTab.values[3]);
              _selectedTab = 3;
            },
          ),
          IconButton(
            icon: Container(
              width: 33.w,
              height: 33.w,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: activecolor)),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                    image: DecorationImage(
                        image: (GetIt.instance
                                        .get<Authenticator>()
                                        .userProfile
                                        .avatarUri ==
                                    "" ||
                                GetIt.instance
                                        .get<Authenticator>()
                                        .userProfile
                                        .avatarUri ==
                                    null)
                            ? AssetImage('asset/avatar.png') as ImageProvider
                            : NetworkImage(GetIt.instance
                                .get<Authenticator>()
                                .userProfile
                                .avatarUri!),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            tooltip: "Hồ sơ",
            onPressed: () {
              widget.onTabSelected(AppTab.values[4]);
              setState(() {
                _selectedTab = 4;
              });
            },
          ),
        ],
      ),
    );
  }
}
