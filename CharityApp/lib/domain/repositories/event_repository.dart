import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/event_detail.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IEventRepository implements CRUDableRepository<EventInfor>{
  // Future<List<EventOverview>> loadEventsOverview(String eventId, int startIndex, int number);
  Future<List<EventOverviewPaticipants>> loadEventsPaticipant(String creatorId, {DateTime? timeStart});
  Future<List<EventOverviewPaticipants>> loadEventsAttending(String userId, {DateTime? timeStart});
  Future<List<EventOverviewPaticipants>> loadEventsPaticipantFromList(List<String> eventId);

  Future<EventOverview> loadEventOverview(String eventId);
  Future<int> getNumberPaticipant(String eventId);
  Future<void> dismiss(String eventId, String userId);

  Future<List<String>> loadImages(String eventId) ;
  Future<EventDetail> loadDetail(String eventId);
  Future<EventPageState> loadStatePage(String eventId, String creatorId);
  Future<void> follow(String eventId, String userId, bool isTrue);
  Future<List<EventOverview>> searchevent(String query, List<TagEvent> tags);

  Future<EventPermission> checkPermission(String eventId, String userId);
}