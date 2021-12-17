import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import './event.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final IEventRepository repository;

  EventBloc({required this.repository}) : super(EventViewLoadInProgress()) {
    on<LoadPostsView>(_onLoadPostView);
    on<LoadDescriptionView>(_onLoadDescriptionView);
    // on<LoadImagesView>(_onLoadImagesView);
    on<UpdateEvent>(_onUpdateEvent);
    on<AddEvent>(_onAddEvent);
    on<DeleteEvent>(_onDeleteEvent);
  }
  

  FutureOr<void> _onLoadPostView(
      LoadPostsView event, Emitter<EventState> emit) {}

  FutureOr<void> _onLoadDescriptionView(
      LoadDescriptionView event, Emitter<EventState> emit) {}

  // FutureOr<void> _onLoadImagesView(
  //     LoadImagesView event, Emitter<EventState> emit) {}

  FutureOr<void> _onUpdateEvent(UpdateEvent event, Emitter<EventState> emit) {}

  FutureOr<void> _onAddEvent(AddEvent event, Emitter<EventState> emit) {
    repository.add(event.event);
  }

  FutureOr<void> _onDeleteEvent(DeleteEvent event, Emitter<EventState> emit) {}
}
