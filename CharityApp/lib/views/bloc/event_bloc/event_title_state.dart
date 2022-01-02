import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:equatable/equatable.dart';


class EventTitleState extends Equatable {
  final EventOverview event;
  final EventPageState pageState;

  const EventTitleState({required this.event, required this.pageState});

  @override
  List<Object?> get props => [event, pageState];
}
