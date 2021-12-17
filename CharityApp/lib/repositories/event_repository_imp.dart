import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'can_crud_repository_imp.dart';

class EventRepositoryImp implements IEventRepository {
  CollectionReference collection;

  EventRepositoryImp(this.collection);

  @override
  Future<void> add(EventInfor entity) async {
    final docref = await collection.add(entity.toJson());
    print(docref.id);
    // return collection.add(entity.toJson());
  }

  @override
  Future<void> delete(String id) {
    return collection.doc(id).delete();
  }

  @override
  Stream<List<EventInfor>> load(String id, int startIndex, int number) {
    throw UnimplementedError();
  }

  @override
  Stream<List<Post>> loadEvents(String id, int number) {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  @override
  Stream<EventOverview> loadEventOverview(String id) {
    // TODO: implement loadOverview
    throw UnimplementedError();
  }

  @override
  Future<void> update(EventInfor id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
