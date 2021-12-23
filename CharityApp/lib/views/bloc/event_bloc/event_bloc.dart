import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/core/helper/uploadImage_firestorage.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import './event.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  final IEventRepository repository = EventRepositoryImp();

  EventBloc() : super(EventViewLoadInProgress()) {
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
      print("Add event to reporistory");
      final rootPath = "images/events";
      EventInfor eventAdded = event.event;

      //Upload image to firestore
      Future<String?>? avatarT;
      Future<String?>? backgroundT;
      if (event.avartarFile != null) {
        avatarT = UploadImageToFirestorage.call(
                imageFile: event.avartarFile!, rootPath: rootPath)
            .then((value) {
          print('Upload avatar of event success');
        });
      }
      if (event.backgroundFile != null) {
        backgroundT = UploadImageToFirestorage.call(
                imageFile: event.backgroundFile!, rootPath: rootPath)
            .then((value) {
          print('Upload background of event success');
        });
      }

      //Get uri path in firestore
      String? avatarUriPath;
      String? backgroundUriPath;
      await Future.wait([
        _createPathUriFor(avatarUriPath, avatarT),
        _createPathUriFor(backgroundUriPath, backgroundT),
      ]);

      //Create uri for current event
      final newEvent = eventAdded.copyWith(
        avatarUri: avatarUriPath == null ? null : Uri(path: avatarUriPath),
        backgroundUri:
            backgroundUriPath == null ? null : Uri(path: backgroundUriPath),
      );
      await repository.add(newEvent);
      print('Add new event complete');

      emit(EventUpdated(event: eventAdded));
    } catch (e) {
      emit(EventLoadFailure());
    }
  }

  FutureOr<void> _onDeleteEvent(DeleteEvent event, Emitter<EventState> emit) {}

  Future<void> _createPathUriFor(String? path, Future<String?>? task) async {
    if (task != null) {
      path = await task;
      if (path == null) {
        emit(EventLoadFailure());
        return;
      }
    }
  }
}
