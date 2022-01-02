
import 'package:bloc/bloc.dart';
import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import 'package:charityapp/views/bloc/event_bloc/event_title_state.dart';

class EventTitleCubit extends Cubit<EventTitleState> {
  IEventRepository repository = EventRepositoryImp();
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
}
