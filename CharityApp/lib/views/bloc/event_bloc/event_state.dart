import 'package:charityapp/core/model/event_tab.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:equatable/equatable.dart';

abstract class EventState extends Equatable {
  const EventState();

  @override
  List<Object> get props => [];
}

class EventViewLoadInProgress extends EventState {}

class EventLoadViewSuccess extends EventState {
  final EventTab activeTab;
  final EventOverview event;
  const EventLoadViewSuccess({required this.activeTab, required this.event});

  @override
  List<Object> get props => [activeTab, event];
}

class EventUpdated extends EventState {
  final EventInfor event;
  const EventUpdated({required this.event});

  @override
  List<Object> get props => [event];
}


class EventLoadFailure extends EventState {}
