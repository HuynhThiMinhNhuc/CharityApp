import 'package:charityapp/Config/fontconfig.dart';
import 'package:charityapp/core/model/routes.dart';
import 'package:charityapp/global_variable/color.dart';
import 'package:charityapp/views/Pages/add_event_page/Witgets/event_card_view.dart';
import 'package:charityapp/views/bloc/calendar_bloc/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with TickerProviderStateMixin {
  DateTime? _selectedDay = DateTime.now();
  DateTime? _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabChanged(_tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(body: BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
        if (state is CalendarLoadEventsSuccess) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.eventPaticipants.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: EventCardView(
                      eventOverviewPaticipants: state.eventPaticipants[index],
                    ),
                    onTap: () => Navigator.of(context).pushNamed(
                        AppRoutes.eventPage,
                        arguments: state.eventPaticipants[index].id),
                  );
                },
              ),
            ),
          );
        } else if (state is CalendarLoadInProccess) {
          return SketonCalendar();
        } else
          return Text('Error');
      },
    ), headerSliverBuilder: (context, value) {
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
              labelStyle: kText15BoldBlack,
              tabs: [
                Tab(text: "Tham gia"),
                Tab(text: "Tổ chức"),
                // Tab(text: "Đang chờ"),
              ],
              onTap: tabChanged),
        ),
      ];
    });
  }

  void Function(int)? tabChanged(int index) {
    if (index < 2) {
      BlocProvider.of<CalendarBloc>(context).add(CalendarLoadEvents(
          timeStart: _selectedDay ?? DateTime.now(),
          tab: CalendarTabs.values[index]));
    } else {
      BlocProvider.of<CalendarBloc>(context).add(CalendarLoadPending());
    }
  }

  Padding getTableCalendar() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        child: TableCalendar(
          locale: "vi",
          rowHeight: 40.h,
          headerStyle: HeaderStyle(
            titleTextStyle: kText17BoldBlack,
            formatButtonVisible: false,
            titleCentered: true,
          ),
          calendarStyle: CalendarStyle(
              rangeHighlightColor: maincolor,
              todayDecoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0x505AA469)),
              selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF5AA469))),
          focusedDay: DateTime.now(),
          firstDay: DateTime.utc(2021, 1, 1),
          lastDay: DateTime.utc(2023, 12, 31),
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _focusedDay = focusedDay;
                _selectedDay = selectedDay;
              });
              tabChanged(_tabController.index);
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

class SketonCalendar extends StatelessWidget {
  const SketonCalendar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SkeletonLoader(
        builder: Column(
          children: <Widget>[
            Row(children: [
              Container(
                width: 90.w,
                height: 70.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: maincolor,
                ),
                margin: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 150.w,
                      height: 20.h,
                      color: maincolor,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    height: 20.h,
                    width: 100.w,
                    color: maincolor,
                  )
                ],
              ),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    "Người tham gia ",
                    softWrap: false,
                    overflow: TextOverflow.fade,
                    style: kText13RegularGreyText,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 0, 0, 8.h),
                  child: Stack(children: [
                    SizedBox(
                      width: 60.w,
                      child: CircleAvatar(radius: 15.w),
                    ),
                    Positioned(right: 10.w, child: CircleAvatar(radius: 15.w)),
                    Positioned(right: 20.w, child: CircleAvatar(radius: 15.w)),
                    Positioned(
                        right: 30.w,
                        child: CircleAvatar(
                          radius: 15.w,
                          backgroundColor: maincolor,
                        )),
                  ]),
                )
              ],
            )
          ],
        ),
        items: 5,
        period: Duration(seconds: 2),
        highlightColor: Color(0x505AA469),
        direction: SkeletonDirection.ltr,
      ),
    );
  }
}
