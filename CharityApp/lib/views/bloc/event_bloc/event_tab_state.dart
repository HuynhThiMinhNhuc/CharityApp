import 'package:charityapp/domain/entities/event_detail.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:equatable/equatable.dart';

abstract class EventTabState extends Equatable {
  const EventTabState();

  @override
  List<Object> get props => [];
}

class EventViewLoadInProgress extends EventTabState {}

abstract class EventLoadSuccess extends EventTabState {
  const EventLoadSuccess();

  @override
  List<Object> get props => [];
}

class EventUpdateSuccess extends EventLoadSuccess {
  final String eventId;
  const EventUpdateSuccess({required this.eventId});
  @override
  List<Object> get props => [eventId];
}

class EventPostViewSuccess extends EventLoadSuccess {
  final List<Post> posts;
  const EventPostViewSuccess({required this.posts});

  @override
  List<Object> get props => [posts];
}

class EventDetailViewSuccess extends EventLoadSuccess {
  final EventDetail detail;

  const EventDetailViewSuccess({required this.detail});

  @override
  List<Object> get props => [detail];
}

class EventPaticipantsViewSuccess extends EventLoadSuccess {
  final int numberFormRegister;
  final int numberPaticipants;

  const EventPaticipantsViewSuccess({required this.numberFormRegister, required this.numberPaticipants});

  @override
  List<Object> get props => [numberFormRegister, numberPaticipants];
}

class EventLoadFailure extends EventTabState {}
