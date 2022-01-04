import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:equatable/equatable.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
  
  @override
  List<Object> get props => [];
}

class CalendarLoadInProccess extends CalendarState {}
class CalendarLoadFailure extends CalendarState{}

class CalendarLoadEventsSuccess extends CalendarState{
  final List<EventOverviewPaticipants> eventPaticipants;
  const CalendarLoadEventsSuccess({required this.eventPaticipants});

    @override
  List<Object> get props => [eventPaticipants];
}