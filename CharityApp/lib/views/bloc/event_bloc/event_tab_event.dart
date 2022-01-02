import 'dart:io';

import 'package:charityapp/core/model/event_tab.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:equatable/equatable.dart';

abstract class EventTabEvent extends Equatable {
  const EventTabEvent();

  @override
  List<Object> get props => [];
}

class LoadEventView extends EventTabEvent {
  final String eventId;
  final EventTab tab;
  const LoadEventView({required this.eventId, required this.tab});

  @override
  List<Object> get props => [eventId, tab];
}

class LoadPagingView extends LoadEventView {
  final int startIndex;
  final int number;
  const LoadPagingView(
      {required this.startIndex,
      required this.number,
      required String eventId,
      required EventTab tab})
      : assert(tab != EventTab.description),
        super(eventId: eventId, tab: tab);

  @override
  List<Object> get props => [eventId, number, startIndex, tab];
}

class AddEvent extends EventTabEvent {
  final EventInfor event;
  final File? avartarFile;
  final File? backgroundFile;
  const AddEvent(
      {required this.event,
      required this.avartarFile,
      required this.backgroundFile});

  @override
  List<Object> get props => [event];
}

class DeleteEvent extends EventTabEvent {
  final BaseEvent event;
  const DeleteEvent({required this.event});

  @override
  List<Object> get props => [event];
}

class UpdateEvent extends EventTabEvent {
  final EventInfor event;
  const UpdateEvent({required this.event});

  @override
  List<Object> get props => [event];
}
