import 'package:charityapp/domain/repositories/email_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailReposityImp extends IEmailReposity {
  final collection = FirebaseFirestore.instance.collection("emails");

  @override
  Future<bool> emailAlreadyExist(String email) async {
    try {
      await collection.doc('1').get().then((value) {
        List<String> emails = [];
        emails = List.from(value.data()!['emails']);
        if (emails.contains(email)) return true;
      });
    } catch (e) {
      print(" ERROR check if email already exists:" + e.toString());
    }
    return false;
  }

  @override
  Future<void> addEmail(String email) async {
    try {
      await collection
          .doc('1')
          .update({
            "emails": FieldValue.arrayUnion([email])
          })
          .then((value) => print("Add email successfully"))
          .catchError(
              (onError) => print("ERROR add email: " + onError.toString()));
    } catch (e) {
      print("ERROR add email:" + e.toString());
    }
  }
}
