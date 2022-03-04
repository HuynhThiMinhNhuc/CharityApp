import 'package:cloud_firestore/cloud_firestore.dart';

class BaseRepositoryImp {
    static Future<DocumentSnapshot?> GetDocAt(Query query, int index) async {
    if (index < 0) return null;
    return query.limit(index+1).snapshots().last.then((value) => (value.docs.isNotEmpty && value.docs.length < index + 1) ? value.docs[0] : null);
  }
}