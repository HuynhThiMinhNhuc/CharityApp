import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/domain/repositories/tag_event_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TagEventRepositoryImp implements ITagEventRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('event_tags');

  // @override
  // Future<List<String>> loadAll() {
  //   return collection.get().then((snapshot) {
  //     return snapshot.docs.map((doc) {
  //       final json = doc.data() as Map<String, dynamic>;
  //       final tag = TagEvent.fromJson(json);
  //       tag.id = doc.id;

  //       return tag.name;
  //     }).toList();
  //   });
  // }

  @override
  Future<List<TagEvent>> loadFrom(String eventId) async {
    //Get tags id from eventId
    final eventCollection = FirebaseFirestore.instance.collection('events');
    
    final tagsId = await eventCollection.doc(eventId).get().then((doc) {
      final json = doc.data() as Map<String, dynamic>;
      print(eventId + ' ' + json['tags'].toString());
      return (json['tags'] as List<dynamic>?)
              ?.map((tag) => tag as String)
              .toList() ??
          <String>[];
    });

    if (tagsId.isNotEmpty) {
      return collection
          .where(FieldPath.documentId, whereIn: tagsId)
          .get()
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          final json = doc.data() as Map<String, dynamic>;
          final tag = TagEvent.fromJson(json)..id=doc.id;

          return tag;
        }).toList();
      });
    } else
      return [];
  }

  Future<List<TagEvent>> loadTags() async {
    return collection.get().then(
          (snapshot) => snapshot.docs.map(
            (doc) {
              final json = doc.data() as Map<String, dynamic>;
              final tag = TagEvent.fromJson(json)..id=doc.id;

              return tag;
            },
          ).toList(),
        );
  }
}
