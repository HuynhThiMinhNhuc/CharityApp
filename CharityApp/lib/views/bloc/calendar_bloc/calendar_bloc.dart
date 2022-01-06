import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/domain/repositories/form_repository.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import 'package:charityapp/repositories/form_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/bloc/calendar_bloc/calendar.dart';
import 'package:get_it/get_it.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  IEventRepository eventRepository = EventRepositoryImp();
  IFormRepository formRepository = FormRepositoryImp();

  CalendarBloc() : super(CalendarLoadInProccess()) {
    on<CalendarLoadEvents>(_onLoadEvents);
    on<CalendarLoadPending>(_onLoadPending);
  }

  FutureOr<void> _onLoadEvents(
    CalendarLoadEvents event,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarLoadInProccess());
    List<EventOverviewPaticipants> events;
    try {
      switch (event.tab) {
        case CalendarTabs.attended:
          {
            events = await eventRepository.loadEventsAttending(Authenticator.Id, timeStart: event.timeStart);
            break;
          }
        case CalendarTabs.organizer:
          {
            events = await eventRepository.loadEventsPaticipant(Authenticator.Id, timeStart: event.timeStart);
            break;
          }
        default:
          throw Exception();
      }
      emit(CalendarLoadEventsSuccess(eventPaticipants: events));
    } catch (e)  {
      emit(CalendarLoadFailure());
    }
  }

  FutureOr<void> _onLoadPending(
    CalendarLoadPending event,
    Emitter<CalendarState> emit,
  ) async {
    emit(CalendarLoadInProccess());

    try {
      final listId = await formRepository.loadEventPendingFrom(Authenticator.Id);
      final events = await eventRepository.loadEventsPaticipantFromList(listId);

      emit(CalendarLoadEventsSuccess(eventPaticipants: events));
    } on Exception catch (e) {
      emit(CalendarLoadFailure());
    }
  }
}
