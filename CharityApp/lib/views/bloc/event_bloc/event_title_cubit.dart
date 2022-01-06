
import 'package:bloc/bloc.dart';
import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/domain/repositories/form_repository.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import 'package:charityapp/repositories/form_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:charityapp/views/bloc/event_bloc/event_title_state.dart';

class EventTitleCubit extends Cubit<EventTitleSuccess> {
  IEventRepository eventRepository = EventRepositoryImp();
  IFormRepository formRepository = FormRepositoryImp();
  EventTitleCubit()
      : super(EventTitleSuccess(
          event: EventOverview(creatorId: '', name: ''),
          permission: EventPermission.notPaticipant,
        ));

  void load(String eventId) async {
    final eventInfor = eventRepository.loadEventOverview(eventId);
    final permission = checkPermission(eventId);
    emit(EventTitleSuccess(event: await eventInfor, permission: await permission));
  }
  Future<EventPermission> checkPermission(String eventId) async {
    return eventRepository.checkPermission(eventId, Authenticator.Id);
  }
}
