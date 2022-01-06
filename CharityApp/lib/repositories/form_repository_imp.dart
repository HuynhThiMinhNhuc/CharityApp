import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/repositories/form_repository.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormRepositoryImp implements IFormRepository {
  final CollectionReference formCollection =
      FirebaseFirestore.instance.collection('form_registers');
  final CollectionReference paticipantsCollection =
      FirebaseFirestore.instance.collection('event_paticipants');

  @override
  Future<void> confirm(String formId, bool isTrue) async {
    final eventCollection = FirebaseFirestore.instance.collection('events');
    final doc = await formCollection.doc(formId).get();

    if (isTrue && doc.exists) {

      //Add to paticipants
      paticipantsCollection.add(<String, dynamic>{
        'userId': doc['userId'],
        'eventId': doc['eventId'],
      });

      //Increase numberlike
      eventCollection.doc(doc['eventId']).update(<String, dynamic>{
        'numberMember': FieldValue.increment(1),
      });
    } else if (!doc.exists) {
      return Future.error('Form does not exists');
      // eventCollection.doc(doc['eventId']).update(<String, dynamic>{
      //   'numberMember': FieldValue.increment(-1),
      // });
    }

    //Delete form
    doc.reference.delete();
  }

  @override
  Future<void> register(FormRegister form) async {
    final eventDoc = await FirebaseFirestore.instance
        .collection('events')
        .doc(form.eventId)
        .get();
    if (!eventDoc.exists) return Future.error('Event not exists');

    final doc = await formCollection.doc(form.id).get();
    if (!doc.exists) formCollection.add(form.toJson());
  }

  @override
  Future<void> unRegister(String eventId, String userId) async {
    final snapshot = await formCollection
        .where('eventId', isEqualTo: eventId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();
    if (snapshot.docs.length == 1) snapshot.docs[0].reference.delete();
  }

  @override
  Future<List<String>> loadEventPendingFrom(String userId) {
    return formCollection.where('userId', isEqualTo: userId).get().then(
        (snapshot) => snapshot.docs
            .map((doc) =>
                (doc.data() as Map<String, dynamic>)['eventId'] as String)
            .toList());
  }

  @override
  Future<int> getNumberForm(String eventId) {
    return formCollection
        .where('eventId', isEqualTo: eventId)
        .get()
        .then((snapshot) => snapshot.docs.length);
  }

  @override
  Future<List<UserOverview>> loadPaticipantsOf(String eventId) async {
    final paticipantSnapshot =
        await paticipantsCollection.where('eventId', isEqualTo: eventId).get();
    final listUserId = paticipantSnapshot.docs
        .map((doc) => (doc.data() as Map<String, dynamic>)['userId'] as String)
        .toList();

    final userRepor = UserRepositoryImp();
    return userRepor.loadOverviewFormList(listUserId);
  }

  @override
  Future<List<UserOverview>> loadRegisterOf(String eventId) async {
    final snapshot =
        await formCollection.where('eventId', isEqualTo: eventId).get();
    final listUserId = snapshot.docs
        .map((doc) => (doc.data() as Map<String, dynamic>)['userId'] as String)
        .toList();

    final userRepor = UserRepositoryImp();
    return userRepor.loadOverviewFormList(listUserId);
  }
}
