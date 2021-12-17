import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  static List<String> assetItem = [
    "asset/Icon/HomeIcon.png",
    "asset/Icon/CalendarIcon.png",
    "asset/Icon/NewIcon.png",
    "asset/Icon/FriendIcon.png",
    "asset/Icon/ProfileIcon.png"
  ];
  static List<String> assetSelectedItem = [
    "asset/Icon/HomeFullIcon.png",
    "asset/Icon/CalendarFullIcon.png",
    "asset/Icon/NewFullIcon.png",
    "asset/Icon/FriendFullIcon.png",
    "asset/Icon/ProfileFullIcon.png",
  ];

  const TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Image.asset(
            tab == activeTab
                ? assetSelectedItem[tab.index]
                : assetItem[tab.index],
            width: 20,
            height: 20,
          ),
          label: tab.toString(),
        );
      }).toList(),
    );
  }
}
