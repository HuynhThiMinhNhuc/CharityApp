import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ICommentRepository {
  Stream<QuerySnapshot> getComments(String postId);
  Future<void> addComment(String postId, UserComment comment);
}