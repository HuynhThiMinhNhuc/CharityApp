import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepositoryImp implements IPostRepository{
  CollectionReference collection;

  PostRepositoryImp(this.collection);

  @override
  Future<void> add(Post entity) {
    return collection.add(entity.toJson());
  }

  @override
  Future<void> delete(String id) {
    return collection.doc(id).delete();
  }

  @override
  Stream<Post> load(String id) {
    return collection.doc(id).snapshots().map((snapshot) {
      return Post.fromJson(snapshot.data() as Map<String, dynamic>);
    });
  }

  @override
  Stream<List<UserComment>> loadComments(String id, int number) {
    // return collection.doc(id).
    // collection('comments').startAt(values).limit(number).
    // snapshots().map((snapshot) {
    //   return snapshot.
    // })

    throw UnimplementedError();
  }

  @override
  Future<void> update(Post entity) {
    return collection.doc(entity.id).update(entity.toJson());
  }
  
}