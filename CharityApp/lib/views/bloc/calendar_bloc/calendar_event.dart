import 'package:equatable/equatable.dart';

enum CalendarTabs {
  attended,
  organizer,
}

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class CalendarLoadEvents extends CalendarEvent {
  final DateTime timeStart;
  final CalendarTabs tab;
  const CalendarLoadEvents({required this.timeStart, required this.tab});

    @override
  List<Object> get props => [timeStart, tab];
}

class CalendarLoadPending extends CalendarEvent{

}