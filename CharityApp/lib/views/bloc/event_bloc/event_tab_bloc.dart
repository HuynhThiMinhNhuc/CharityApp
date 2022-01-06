import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/core/helper/uploadImage_firestorage.dart';
import 'package:charityapp/core/model/event_tab.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/domain/repositories/form_repository.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import 'package:charityapp/repositories/form_repository_imp.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'event.dart';

class EventTabBloc extends Bloc<EventTabEvent, EventTabState> {
  final IEventRepository eventRepository = EventRepositoryImp();
  final IPostRepository postRepository = PostRepositoryImp();
  final IFormRepository formRepository = FormRepositoryImp();

  EventTabBloc() : super(EventViewLoadInProgress()) {
    on<LoadEventView>(_onLoadEventView);
    // on<LoadImagesView>(_onLoadImagesView);
    on<UpdateEvent>(_onUpdateEvent);
    on<AddEvent>(_onAddEvent);
    on<DeleteEvent>(_onDeleteEvent);
  }

  FutureOr<void> _onLoadEventView(
      LoadEventView event, Emitter<EventTabState> emit) async {
        emit(EventViewLoadInProgress());
    switch (event.tab) {
      case EventTab.posts:
        {
          if (event is LoadPagingView) {
            final posts = postRepository.load(
                event.eventId, event.startIndex, event.number);
            emit(EventPostViewSuccess(posts: await posts));
          }
        }
        break;
      case EventTab.description:
        {
          final detail = eventRepository.loadDetail(event.eventId);
          emit(EventDetailViewSuccess(detail: await detail));
        }
        break;
      case EventTab.paticipants:
        {
          final task1 = formRepository.getNumberForm(event.eventId);
          final task2 = eventRepository.getNumberPaticipant(event.eventId);

          final complete = await Future.wait<int>([task1, task2]);

          emit(EventPaticipantsViewSuccess(numberFormRegister: complete[0], numberPaticipants: complete[1]));
        }
        break;
      default:
        emit(EventLoadFailure());
    }
  }

  FutureOr<void> _onUpdateEvent(
      UpdateEvent event, Emitter<EventTabState> emit) {}

  FutureOr<void> _onAddEvent(
      AddEvent event, Emitter<EventTabState> emit) async {
    try {
      print("Add event to reporistory");
      final rootPath = "images/events";
      EventInfor eventAdded = event.event;

      //Upload image to firestore
      Future<String?>? avatarT;
      Future<String?>? backgroundT;

      String? avatarUriPath;
      String? backgroundUriPath;

      if (event.avartarFile != null) {
        avatarT = UploadImageToFirestorage.call(
                imageFile: event.avartarFile!, rootPath: rootPath)
            .then((value) {
          print('Upload avatar of event success');
          avatarUriPath = value;
        });
      }
      if (event.backgroundFile != null) {
        backgroundT = UploadImageToFirestorage.call(
                imageFile: event.backgroundFile!, rootPath: rootPath)
            .then((value) {
          print('Upload background of event success');
          backgroundUriPath = value;
        });
      }

      //Get uri path in firestore
      await Future.wait<String?>([
        Future.value(avatarT),
        Future.value(backgroundT),
      ]);

      //Create uri for current event
      final newEvent = eventAdded.copyWith(
        avatarUri: avatarUriPath,
        backgroundUri: backgroundUriPath,
        timeCreate: DateTime.now(),
      );
      await eventRepository.add(newEvent);
      print('Add new event complete');

      emit(EventUpdateSuccess(eventId: newEvent.id!));
    } catch (e) {
      emit(EventLoadFailure());
    }
  }

  FutureOr<void> _onDeleteEvent(
      DeleteEvent event, Emitter<EventTabState> emit) {}
}
