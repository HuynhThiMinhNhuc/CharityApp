import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/event_detail.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventRepositoryImp implements IEventRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("events");
  final CollectionReference paticipantCollection =
      FirebaseFirestore.instance.collection("event_paticipants");

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

  // @override
  // Future<List<EventOverview>> loadEventsOverview(
  //     String creatorId, int startIndex, int number) {
  //   return collection
  //       .where('creatorId', isEqualTo: creatorId)
  //       .orderBy('timeCreate', descending: true)
  //       .get()
  //       .then((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       final json = doc.data() as Map<String, dynamic>;
  //       final event = EventOverview.fromJson(json);
  //       event.id = doc.id;
  //       return event;
  //     }).toList();
  //   });
  // }

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
    List<Future<void>> paticipantsTask = [];

    final events = await collection
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
            return (paticipantsDoc.data() as Map<String, dynamic>)['avatarUri']
                as String?;
          }).toList();
          event.paticipantsUri = paticipants;
        }));

        event.id = eventDoc.id;

        return event;
      }).toList();
    });

    await Future.wait(paticipantsTask);

    return events;
  }

  @override
  Future<EventOverview> loadEventOverview(String eventId) {
    return collection.doc(eventId).get().then((doc) {
      final json = doc.data() as Map<String, dynamic>;
      final event = EventOverview.fromJson(json)..id = doc.id;
      
      return event;
    });
  }

  @override
  Future<List<String>> loadImages(String eventId) async {
    List<String> images = [];
    final postRepository = PostRepositoryImp();
    collection.where('eventId', isEqualTo: eventId).get().then((snapshot) {
      return snapshot.docs.map((doc) async {
        print('images run');
        images.addAll(await postRepository.loadImages(doc.id));
        print('images end');
      }).toList();
    });

    return images;
  }

  @override
  Future<EventDetail> loadDetail(String eventId) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    final event = await collection.doc(eventId).get().then((doc) async {
      final json = doc.data() as Map<String, dynamic>;
      final element = EventDetail.fromJson(json)..id = doc.id;
      await userCollection.doc(json['creatorId']).get().then((userDoc) {
        element.creator =
            BaseUser.fromJson(userDoc.data() as Map<String, dynamic>)
              ..id = userDoc.id;
      });

      return element;
    });

    return event;
  }

  @override
  Future<EventPageState> loadStatePage(String eventId, String creatorId) async {
    final snapshot = await paticipantCollection
        .where('eventId', isEqualTo: eventId)
        .where('creatorId', isEqualTo: creatorId)
        .limit(1)
        .get();

    if (snapshot.docs.length == 0) return EventPageState.notFollow;
    if (snapshot.docs.length == 1) return EventPageState.followed;
    throw Exception();
  }

  @override
  Future<void> follow(String eventId, String userId, bool isTrue) async {
    final snapshot = await paticipantCollection
        .where('eventId', isEqualTo: eventId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();
    if (isTrue && snapshot.docs.length == 0) {
      paticipantCollection.add(<String, dynamic>{
        'eventId': eventId,
        'userId': userId,
      });
    }
    else if (!isTrue && snapshot.docs.length == 1) {
      snapshot.docs[0].reference.delete();
    }
  }
}
