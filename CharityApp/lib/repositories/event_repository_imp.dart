import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';

class EventRepositoryImp implements IEventRepository {
  @override
  Future<void> add(EventInfor entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<EventInfor> load(String id) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future<List<Post>> loadEvents(String id, int number) {
    // TODO: implement loadEvents
    throw UnimplementedError();
  }

  @override
  Future<EventOverview> loadOverview(String id) {
    // TODO: implement loadOverview
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id) {
    // TODO: implement update
    throw UnimplementedError();
  }

}