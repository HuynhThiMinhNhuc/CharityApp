import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepositoryImp implements IPostRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("posts");

  PostRepositoryImp();

  @override
  Future<void> add(Post entity) {
    return collection.add(entity.toJson());
  }

  @override
  Future<void> delete(String id) {
    return collection.doc(id).delete();
  }

  @override
  Stream<List<Post>> load(String eventId, int startIndex, int number) {
    final CollectionReference userscollection =
        FirebaseFirestore.instance.collection("users");

    return collection
        .where('eventId', isEqualTo: eventId)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data()! as Map<String, dynamic>;
        final post = Post.fromJson(json);
        UserOverview newuser = UserOverview(name: 'Jane Nguyễn', avatarUri: null);
        post.creator = newuser;
        // await userscollection.doc('${json['creatorId']}').get().then((value) =>
        //     post.creator =
        //         UserOverview.fromJson(value.data() as Map<String, dynamic>));
        return post;
      }).toList();
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
