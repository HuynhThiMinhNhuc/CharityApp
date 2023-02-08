import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/repositories/comment_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentRepositoryImp extends ICommentRepository {
  final CollectionReference postCollection =
      FirebaseFirestore.instance.collection('posts');

  @override
  Future<void> addComment(String postId, UserComment comment) {
    return postCollection
        .doc(postId)
        .collection('comments')
        .add(comment.toJson())
        .then((doc) {
      comment.id = doc.id;
    });
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getComments(String postId) {
    return postCollection
        .doc(postId)
        .collection('comments')
        .orderBy('timeComment', descending: true)
        .snapshots();
  }

  Future<UserComment> getComment(Map<String, dynamic> json) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(json['creatorId'])
        .get()
        .then((doc) {
      return UserComment(
        id: doc.id,
        name: doc['name'],
        avatarUri: doc['avatarUri'],
        content: json['content'],
        timeComment: (json['timeComment'] as Timestamp).toDate(),
        // nlp: json['nlp']
      );
    });
  }
}
