import 'package:charityapp/core/model/event_page_state.dart';
import 'package:charityapp/domain/entities/base_event.dart';
import 'package:charityapp/domain/entities/base_user.dart';
import 'package:charityapp/domain/entities/event_detail.dart';
import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_infor.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tiengviet/tiengviet.dart';

class EventRepositoryImp implements IEventRepository {
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection("events");
  final CollectionReference paticipantCollection =
      FirebaseFirestore.instance.collection("event_paticipants");

  @override
  Future<void> add(EventInfor entity) async {
    final docref = await eventCollection
        .add(entity.toJson()..addAll({'numberMember': 0, 'numberPost': 0}));
    entity.id = docref.id;
    print('Add ${entity.toString()} success');
  }

  @override
  Future<void> delete(String id) {
    return eventCollection
        .doc(id)
        .delete()
        .then((value) => print('Update $id success'));
  }

  @override
  Future<List<EventInfor>> load(String creatorId, int startIndex, int number) {
    return eventCollection
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
    return eventCollection
        .doc(entity.id)
        .update(entity.toJson())
        .then((value) => print('Update ${entity.toString()} success'));
  }

  @override
  Future<List<EventOverviewPaticipants>> loadEventsPaticipant(String creatorId,
      {DateTime? timeStart}) async {
    List<Future<void>> paticipantsTask = [];

    var query = eventCollection.where('creatorId', isEqualTo: creatorId);
    if (timeStart != null) {
      query = query.where('timeStart',
          isGreaterThanOrEqualTo:
              DateTime(timeStart.year, timeStart.month, timeStart.day));
      query = query.where('timeStart',
          isLessThan:
              DateTime(timeStart.year, timeStart.month, timeStart.day + 1));
    }

    final events = _getEventsPaticipant(query.get(), paticipantsTask);

    // final events = await collection
    //     .where('creatorId', isEqualTo: creatorId)
    //     .get()
    //     .then((snapshot) {
    //   return snapshot.docs.map((eventDoc) {
    //     final json = eventDoc.data() as Map<String, dynamic>;
    //     final event = EventOverviewPaticipants.fromJson(json);

    //     //Load paticipants
    //     paticipantsTask.add(paticipantCollection
    //         .where('eventId', isEqualTo: eventDoc.id)
    //         .get()
    //         .then((snapshot) {
    //       final paticipants = snapshot.docs.map((paticipantsDoc) {
    //         return (paticipantsDoc.data() as Map<String, dynamic>)['avatarUri']
    //             as String?;
    //       }).toList();
    //       event.paticipantsUri = paticipants;
    //     }));

    //     event.id = eventDoc.id;

    //     return event;
    //   }).toList();
    // });

    await Future.wait(paticipantsTask);

    return events;
  }

  @override
  Future<List<EventOverviewPaticipants>> loadEventsAttending(String userId,
      {DateTime? timeStart}) async {
    List<Future<void>> paticipantsTask = [];

    //Search list event from collection event_paticipants
    final listId = await paticipantCollection
        .where('userId', isEqualTo: userId)
        .get()
        .then((snapshot) => snapshot.docs
            .map((doc) =>
                (doc.data() as Map<String, dynamic>)['eventId'] as String)
            .toList());

    //Load event
    if (listId.isNotEmpty) {
      var query = eventCollection.where(FieldPath.documentId, whereIn: listId);
      List<EventOverviewPaticipants> events = [];

      if (timeStart == null) {
        events = await _getEventsPaticipant(query.get(), paticipantsTask);
      } else {
        final startDay =
            DateTime(timeStart.year, timeStart.month, timeStart.day);
        final endDay =
            DateTime(timeStart.year, timeStart.month, timeStart.day + 1);

        await query.get().then((snapshot) {
          return snapshot.docs.forEach((eventDoc) {
            final json = eventDoc.data() as Map<String, dynamic>;
            if ((json['timeStart'] as Timestamp).toDate().compareTo(startDay) >=
                    0 &&
                (json['timeStart'] as Timestamp).toDate().compareTo(endDay) <
                    0) {
              final event = EventOverviewPaticipants.fromJson(json)
                ..id = eventDoc.id;

              final userRepository = UserRepositoryImp();
              paticipantsTask.add(
                userRepository
                    .loadAvatarUriPaticipant(eventDoc.id)
                    .then((value) {
                  event.paticipantsUri = value;
                }),
              );

              events.add(event);
            }
          });
        });
      }
      await Future.wait(paticipantsTask);

      return events;
    } else
      return [];
  }

  Future<List<EventOverviewPaticipants>> _getEventsPaticipant(
      Future<QuerySnapshot<Object?>> query, List<Future> tasks) async {
    return query.then((snapshot) => snapshot.docs.map((eventDoc) {
          final json = eventDoc.data() as Map<String, dynamic>;
          final event = EventOverviewPaticipants.fromJson(json)
            ..id = eventDoc.id;

          //Load paticipantsUri
          final userRepository = UserRepositoryImp();
          tasks.add(
            userRepository.loadAvatarUriPaticipant(eventDoc.id).then((value) {
              event.paticipantsUri = value;
            }),
          );

          return event;
        }).toList());
  }

  @override
  Future<List<EventOverviewPaticipants>> loadEventsPaticipantFromList(
      List<String> listId) async {
    List<Future<void>> paticipantsTask = [];

    //Load event
    if (listId.isNotEmpty) {
      final query =
          eventCollection.where(FieldPath.documentId, whereIn: listId).get();
      final events = await _getEventsPaticipant(query, paticipantsTask);

      await Future.wait(paticipantsTask);

      return events;
    } else
      return [];
  }

  @override
  Future<EventOverview> loadEventOverview(String eventId) {
    return eventCollection.doc(eventId).get().then((doc) {
      final json = doc.data() as Map<String, dynamic>;
      final event = EventOverview.fromJson(json)..id = doc.id;

      return event;
    });
  }

  @override
  Future<List<String>> loadImages(String eventId) async {
    List<String> images = [];
    final postRepository = PostRepositoryImp();
    eventCollection.where('eventId', isEqualTo: eventId).get().then((snapshot) {
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
    final event = await eventCollection.doc(eventId).get().then((doc) async {
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
    } else if (!isTrue && snapshot.docs.length == 1) {
      snapshot.docs[0].reference.delete();
    }
  }

  @override
  Future<List<EventOverview>> searchevent(
      String query, List<String> tags) async {
    List<EventOverview> listEvent = [];
    try {
      var unOrdDeepEq = const DeepCollectionEquality.unordered().equals;
      await eventCollection.get().then((value) => value.docs.forEach((element) {
            if ((query == "" && (CheckListContain(element['tags'], tags))) ||
                ((CheckListContain(element['tags'], tags)) &&
                    TiengViet.parse(element['name'].toString().toLowerCase())
                        .contains(TiengViet.parse(query.toLowerCase())))) {
              EventOverview eventOverview = new EventOverview(
                  name: element['name'],
                  avatarUri: element['avatarUri'],
                  id: element.id,
                  creatorId: element['creatorId']);
              listEvent.add(eventOverview);
            }
          }));
      return listEvent;
    } catch (e) {
      print("Erro search event reposity");
      return listEvent;
    }
  }

  bool CheckListContain(List<dynamic> l1, List<String> l2) {
    if (l2.length == 0) return true;
    if (l1.length < l2.length) return false;
    for (var i in l2) {
      if (!l1.contains(i)) return false;
    }
    return true;
  }

  @override
  Future<int> getNumberPaticipant(String eventId) {
    return paticipantCollection
        .where('eventId', isEqualTo: eventId)
        .get()
        .then((snapshot) => snapshot.docs.length);
  }

  @override
  Future<void> dismiss(String eventId, String userId) {
    return paticipantCollection
        .where('eventId', isEqualTo: eventId)
        .where('userId', isEqualTo: userId)
        .get()
        .then((snapshot) {
      final docs = snapshot.docs;
      if (docs.length > 1)
        return Future.error('Number of docs not larger than 1');

      if (docs.length == 1) {
        return docs[0].reference.delete();
      }
    });
  }

  Future<EventPermission> checkPermission(String eventId, String userId) async {
    //Check admin
    final eventDoc = await eventCollection.doc(eventId).get();
    if (eventDoc.exists) {
      final id =
          (eventDoc.data() as Map<String, dynamic>)['creatorId'] as String;
      if (id == userId) return EventPermission.admin;
    }

    //Check join
    final paticipantDoc =
        await paticipantCollection.where('eventId', isEqualTo: eventId).get();
    if (paticipantDoc.docs.isNotEmpty) {
      final jsons = paticipantDoc.docs.map((doc) => doc.data()).toList();

      for (var json in jsons) {
        if ((json as Map<String, dynamic>)['userId'] == userId)
          return EventPermission.joined;
      }
    }

    //Check pending
    final formCollection =
        FirebaseFirestore.instance.collection('form_registers');
    final formDoc = await formCollection
        .where('userId', isEqualTo: userId)
        .where('eventId', isEqualTo: eventId)
        .get();
    if (formDoc.docs.isNotEmpty) return EventPermission.pending;

    //Return not paticipant
    return EventPermission.notPaticipant;
  }
}
