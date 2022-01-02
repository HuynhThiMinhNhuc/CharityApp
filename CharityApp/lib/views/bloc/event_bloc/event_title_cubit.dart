
import 'package:bloc/bloc.dart';
import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/domain/repositories/form_repository.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import 'package:charityapp/repositories/form_repository_imp.dart';
import 'package:charityapp/views/bloc/event_bloc/event_title_state.dart';

class EventTitleCubit extends Cubit<EventTitleState> {
  IEventRepository repository = EventRepositoryImp();
  IFormRepository formRepository = FormRepositoryImp();
  EventTitleCubit()
      : super(EventTitleState(
          event: EventOverview(creatorId: '', name: ''),
          pageState: EventPageState.notFollow,
        ));

  void load(String eventId) async {
    final eventInfor = repository.loadEventOverview(eventId);
    final myId = 'pJy3h4OgWHG4a2BsylIN';
  final state = repository.loadStatePage(eventId, myId);
    emit(EventTitleState(event: await eventInfor, pageState: await state));
  }

  void follow(String eventId, bool isTrue) {
    String myId = 'test';
    repository.follow(eventId, myId, isTrue);
  }

  void register(FormRegister form) {
    formRepository.register(form);
  }
  void unregister(String eventId) {
    String myId ='';
    formRepository.unRegister(eventId, myId);
  }
}
