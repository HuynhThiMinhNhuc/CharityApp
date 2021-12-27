import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/add_event_page/Witgets/event_card_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  DateTime? _selectedDay;
  DateTime? _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return EventCardView(
            number: 3,
            time: DateTime.now(),
            title: 'Sự kiện vận chuyển đồ đạc cho người già neo đơn',
          );
        },
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return EventCardView(
            number: 3,
            time: DateTime.now(),
            title: 'Sự kiện vận chuyển đồ đạc cho người già neo đơn',
          );
        },
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return EventCardView(
            number: 3,
            time: DateTime.now(),
            title: 'Sự kiện vận chuyển đồ đạc cho người già neo đơn',
          );
        },
      )
    ];
    TabController _tabController =
        new TabController(length: tabs.length, vsync: this);
    return NestedScrollView(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: TabBarView(controller: _tabController, children: tabs),
          ),
        ),
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: getTableCalendar(),
            ),
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.white,
              title: TabBar(
                  indicatorColor: maincolor,
                  unselectedLabelColor: Color(0xFF757070),
                  controller: _tabController,
                  labelColor: maincolor,
                  labelStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  tabs: [
                    Tab(text: "Tham gia"),
                    Tab(text: "Tổ chức"),
                    Tab(text: "Chờ duyệt"),
                  ]),
            ),
          ];
        });
  }

  Padding getTableCalendar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: TableCalendar(
          locale: "vi",
          rowHeight: 42,
          headerStyle: HeaderStyle(
              titleTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
          calendarStyle: CalendarStyle(
              rangeHighlightColor: maincolor,
              todayDecoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0x505AA469)),
              selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF5AA469))),
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2021, 1, 1),
          lastDay: DateTime.utc(2021, 12, 31),
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: maincolor)),
      ),
    );
  }
}
