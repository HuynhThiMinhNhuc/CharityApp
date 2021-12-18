import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:equatable/equatable.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}
abstract class LoadView extends EventEvent{
  final String eventId;
  const LoadView({required this.eventId});

    @override
  List<Object> get props => [eventId];
}
class LoadPostsView extends LoadView {
  LoadPostsView({required String eventId}): super(eventId: eventId);
}

class LoadDescriptionView extends LoadView {
  LoadDescriptionView({required String eventId}) : super(eventId: eventId);
}

// class LoadImagesView extends LoadView {
//   LoadImagesView({required String eventId}) : super(eventId: eventId);
// }

class AddEvent extends EventEvent {
  final EventInfor event;
  const AddEvent({required this.event});

  @override
  List<Object> get props => [event];
}

class DeleteEvent extends EventEvent {
  final BaseEvent event;
  const DeleteEvent({required this.event});

  @override
  List<Object> get props => [event];
}

class UpdateEvent extends EventEvent {
  final EventInfor event;
  const UpdateEvent({required this.event});

  @override
  List<Object> get props => [event];
}
