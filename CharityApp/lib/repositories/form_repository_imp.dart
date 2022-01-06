import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/repositories/form_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FormRepositoryImp implements IFormRepository {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('forms');

  @override
  Future<void> confirm(String formId, bool isTrue) async {
    final eventCollection = FirebaseFirestore.instance.collection('events');
    final doc = await collection.doc(formId).get();

    if (isTrue) {
      final paticipantCollection =
          FirebaseFirestore.instance.collection('event_paticipants');

      //Add to paticipants
      paticipantCollection.add(<String, dynamic>{
        'userId': doc['userId'],
        'eventId': doc['eventId'],
      });

      //Increase numberlike
      eventCollection.doc(doc['eventId']).update(<String, dynamic>{
        'numberMember': FieldValue.increment(1),
      });
    } else {
      eventCollection.doc(doc['eventId']).update(<String, dynamic>{
        'numberMember': FieldValue.increment(-1),
      });
    }

    //Delete form
    doc.reference.delete();
  }

  @override
  Future<void> register(FormRegister form) async {
    final doc = await collection.doc(form.id).get();
    if (!doc.exists) collection.add(form.toJson());
  }

  @override
  Future<void> unRegister(String eventId, String userId) async {
    final snapshot = await collection
        .where('eventId', isEqualTo: eventId)
        .where('userId', isEqualTo: userId)
        .limit(1)
        .get();
    if (snapshot.docs.length == 1) snapshot.docs[0].reference.delete();
  }

  @override
  Future<List<String>> loadEventPendingFrom(String userId) {
    return collection.where('userId', isEqualTo: userId).get().then(
        (snapshot) => snapshot.docs
            .map((doc) =>
                (doc.data() as Map<String, dynamic>)['eventId'] as String)
            .toList());
  }

  @override
  Future<int> getNumberForm(String eventId) {
    return collection.where('eventId', isEqualTo: eventId).get().then((snapshot) => snapshot.docs.length);
  }
}
