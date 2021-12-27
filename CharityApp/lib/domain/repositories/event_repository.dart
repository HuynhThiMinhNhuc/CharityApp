import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IEventRepository implements CRUDableRepository<EventInfor>{
  Future<List<EventOverview>> loadEventsOverview(String eventId, int startIndex, int number);
  Future<List<EventOverviewPaticipants>> loadEventsPaticipant(String creatorId);
}