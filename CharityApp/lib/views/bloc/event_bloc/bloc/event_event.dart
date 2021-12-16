part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();

  @override
  List<Object> get props => [];
}

class EventLoadPostView extends EventEvent{ }
class EventLoadDescriptionView extends EventEvent{ }
class EventLoadSuccess extends EventEvent{ }
class EventLoadFairlure extends EventEvent{ }
