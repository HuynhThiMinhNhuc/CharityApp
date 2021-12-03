import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IEventRepository implements AbleCRUDRepository<EventInfor>{
  Future<EventOverview> loadOverview(String id);
  Future<List<Post>> loadEvents(String id, int number);
}