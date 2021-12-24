import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepositoryImp implements IEventRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("events");

  @override
  Future<void> add(EventInfor entity) async {
    final docref = await collection.add(entity.toJson());
    entity.id = docref.id;
    print('Add ${entity.toString()} success');
  }

  @override
  Future<void> delete(String id) {
    return collection
        .doc(id)
        .delete()
        .then((value) => print('Update $id success'));
  }

  @override
  Future<List<EventInfor>> load(String creatorId, int startIndex, int number) {
    return collection
        .where('creatorId', isEqualTo: creatorId)
        .orderBy('timeCreate', descending: true)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        final event = EventInfor.fromJson(json);
        event.id = doc.id;
        return event;
      }).toList();
    });
  }

  @override
  Future<List<EventOverview>> loadEventsOverview(
      String creatorId, int startIndex, int number) {
    return collection
        .where('creatorId', isEqualTo: creatorId)
        .orderBy('timeCreate', descending: true)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        final event = EventOverview.fromJson(json);
        event.id = doc.id;
        return event;
      }).toList();
    });
  }

  @override
  Future<void> update(EventInfor entity) {
    return collection
        .doc(entity.id)
        .update(entity.toJson())
        .then((value) => print('Update ${entity.toString()} success'));
  }

  @override
  Future<List<EventOverviewPaticipants>> loadEventsPaticipant(
      String creatorId) async {
    final paticipantCollection =
        FirebaseFirestore.instance.collection('event_paticipants');
    List<Future<void>> paticipantsTask = [];

    final task = await collection
        .where('creatorId', isEqualTo: creatorId)
        // .orderBy('timeStart')
        .get()
        .then((snapshot) {
      return snapshot.docs.map((eventDoc) {
        final json = eventDoc.data() as Map<String, dynamic>;
        final event = EventOverviewPaticipants.fromJson(json);

        //Load paticipants
        paticipantsTask.add(paticipantCollection
            .where('eventId', isEqualTo: eventDoc.id)
            .get()
            .then((snapshot) {
          final paticipants = snapshot.docs.map((paticipantsDoc) {
            return paticipantsDoc.data()['avatarUri'] as String?;
          }).toList();
          event.paticipantsUri = paticipants;
        }));

        event.id = eventDoc.id;

        return event;
      }).toList();
    });

    await Future.wait(paticipantsTask);

    return task;
  }
}
