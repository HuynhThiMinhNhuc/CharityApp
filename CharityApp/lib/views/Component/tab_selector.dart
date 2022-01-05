import 'package:charityapp/core/model/app_tab.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/Pages/add_event_page/add_event_page.dart';
import 'package:charityapp/views/Pages/add_event_page/add_post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
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
            label: 'Calendar', icon: Icon(Icons.calendar_today_rounded)),
        BottomNavigationBarItem(
          label: '',
          icon: SpeedDial(
            backgroundColor: Colors.black,
            animatedIcon: AnimatedIcons.add_event,
            animatedIconTheme: IconThemeData(size: 25),
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
                  child:
                      Icon(Icons.event_available_outlined, color: Colors.white),
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
                      image: GetIt.instance
                                  .get<Authenticator>()
                                  .userProfile
                                  .avatarUri ==
                              null
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
        ),
      ],
    );
  }
}
