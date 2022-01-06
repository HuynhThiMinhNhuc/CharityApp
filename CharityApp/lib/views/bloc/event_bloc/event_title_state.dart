import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:equatable/equatable.dart';


class EventTitleSuccess extends Equatable {
  final EventOverview event;
  final EventPermission permission;

  const EventTitleSuccess({required this.event, required this.permission});

  @override
  List<Object?> get props => [permission];
}
