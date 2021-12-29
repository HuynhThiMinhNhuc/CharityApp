import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/repositories/comment_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CommentRepositoryImp extends ICommentRepository {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> addComment(String postId, UserComment comment) {
    return postCollection
        .doc(postId)
        .collection('comments')
        .add(comment.toJson());
  }

  @override
  Stream<QuerySnapshot<Object?>> getComments(String postId) {
    return postCollection
        .doc(postId)
        .collection('comments')
        .orderBy('timeComment', descending: true)
        .limit(5)
        .snapshots();
  }

  Future<UserComment> getComment(Map<String, dynamic> json) {
    return FirebaseFirestore.instance.collection('users').doc(json['creatorId']).get().then((doc) {
      return UserComment(name: doc['name'], avatarUri: doc['avatarUri'], content: json['content'], timeComment:  (json['timeComment'] as Timestamp).toDate());
    });
  }
}
