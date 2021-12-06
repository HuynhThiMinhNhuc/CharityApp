import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IEventRepository implements CRUDableRepository<EventInfor>{
  Stream<EventOverview> loadEventOverview(String id);
  Stream<List<Post>> loadEvents(String id, int number);
}