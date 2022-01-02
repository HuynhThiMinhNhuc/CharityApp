import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/domain/repositories/tag_event_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TagEventRepositoryImp implements ITagEventRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('event_tags');

  TagEventRepositoryImp();

  @override
  Future<List<TagEvent>> loadAll() {
    return collection.get().then((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        final tag = TagEvent.fromJson(json);
        tag.id = doc.id;

        return tag;
      }).toList();
    });
  }

  @override
  Future<List<TagEvent>> loadFrom(String eventId) async {
    //Get tags id from eventId
    final eventCollection = FirebaseFirestore.instance.collection('events');
    final tagsId = await eventCollection.doc(eventId).get().then((doc) {
      final json = doc.data() as Map<String, dynamic>;
      return json['tags'] as List<String>;
    });

    return collection
        .where(FieldPath.documentId, whereIn: tagsId)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        final tag = TagEvent.fromJson(json);
        tag.id = doc.id;

        return tag;
      }).toList();
    });
  }

  Future<List<String>> loadTags() async {
    List<String> tags = [];
    await collection.get().then((value) => value.docs.forEach((element) {
          tags.add(element['vn']);
        }));
    return tags;
  }
}
