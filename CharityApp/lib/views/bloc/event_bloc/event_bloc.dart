import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/core/helper/uploadImage_firestorage.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
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

  FutureOr<void> _onAddEvent(AddEvent event, Emitter<EventState> emit) async {
    try {
      print("AddEvent Reporistory");
      final rootPath = "images/events";
      Future<String?>? avatarT;
      Future<String?>? backgroundT;
      if (event.avartarFile != null) {
        avatarT = UploadImageToFirestorage.call(
            imageFile: event.avartarFile!, rootPath: rootPath);
      }
      if (event.backgroundFile != null) {
        backgroundT = UploadImageToFirestorage.call(
            imageFile: event.backgroundFile!, rootPath: rootPath);
      }
      String? avatarUriPath;
      String? backgroundUriPath;
      await Future.wait([
        (() async {
          if (avatarT != null) {
            final path = await avatarT;
            if (path == null) {
              emit(EventLoadFailure());
              return;
            }
            avatarUriPath = path;
          }
        })(),
        (() async {
          if (backgroundT != null) {
            final path = await backgroundT;
            if (path == null) {
              emit(EventLoadFailure());
              return;
            }
            backgroundUriPath = path;
          }
        })(),
      ]);
      final newEvent = event.event.copyWith(
        avatarUri: avatarUriPath == null ? null : Uri(path: avatarUriPath),
        backgroundUri:
            backgroundUriPath == null ? null : Uri(path: backgroundUriPath),
      );
      await repository.add(newEvent);
      emit(EventUpdated(event: event.event));
    } catch (e) {
      emit(EventLoadFailure());
    }
  }

  FutureOr<void> _onDeleteEvent(DeleteEvent event, Emitter<EventState> emit) {}
}
