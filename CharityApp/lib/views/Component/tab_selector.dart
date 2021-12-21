import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:flutter/material.dart';
//ignore: import_of_legacy_library_into_null_safe
// import 'package:flat_icons_flutter/flat_icons_flutter.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: maincolor,
      unselectedItemColor: Colors.black,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      iconSize: 27,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: 'Calendar',
          icon: Icon(Icons.home /*FlatIcons.calendar*/),
        ),
        BottomNavigationBarItem(
          label: 'New',
          icon: Icon(Icons.add_box),
        ),
        BottomNavigationBarItem(
          label: 'Friend',
          icon: Icon(Icons.people),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Container(
            width: 31,
            height: 31,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: activecolor)),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
