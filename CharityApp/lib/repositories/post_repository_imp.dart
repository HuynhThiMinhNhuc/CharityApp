import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostRepositoryImp implements IPostRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("posts");

  @override
  Future<void> add(Post entity) async {
    final docRef = await collection
        .add(entity.toJson()..addAll({'timeCreate': DateTime.now()}));
    entity.id = docRef.id;
    print('Add ${entity.toString()} success');

    final eventCollection = FirebaseFirestore.instance.collection("events");
    eventCollection.doc(entity.eventId).update(<String, dynamic>{
      'numberPost': FieldValue.increment(1),
    });
  }

  @override
  Future<void> delete(String id) {
    final docRef = collection.doc(id);

    docRef.get().then((doc) {
      final json = doc.data() as Map<String, dynamic>;
      final eventCollection = FirebaseFirestore.instance.collection("events");

      eventCollection.doc(json['eventId']).update(<String, dynamic>{
        'numberPost': FieldValue.increment(-1),
      });
    });

    return docRef.delete().then((value) => print('Delete $id success'));
  }

  @override
  Future<List<Post>> load(String eventId, int startIndex, int number) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    List<Future> tasks = <Future>[];

    final posts = await collection
        .where('eventId', isEqualTo: eventId)
        // .orderBy('timeCreate', descending: true)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((docPost) {
        final postJson = docPost.data() as Map<String, dynamic>;
        final post = Post.fromJson(postJson);
        post.id = docPost.id; //Set doc id
        // post.creator = UserOverview(name: 'test', avatarUri: Uri(path: "avatarUri"));

        //Load UserOverview
        tasks.add(userCollection.doc(postJson['creatorId']).get().then(
          (docUser) {
            post.creator =
                UserOverview.fromJson(docUser.data() as Map<String, dynamic>);
            post.id = docUser.id; //Set doc id
          },
        ));

        return post;
      }).toList();
    });

    await Future.wait(tasks);
    return posts;
  }

  @override
  Future<List<Post>> loadRandomPosts(int startIndex, int number) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    List<Future> tasks = <Future>[];
    final myId = '7hKHP4tpuIyeTJ44IdJe';

    final posts = await collection
        .orderBy('timeCreate', descending: true)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((docPost) {
        final postJson = docPost.data() as Map<String, dynamic>;
        final post = Post.fromJson(postJson);
        post.numberLike = (postJson['like'] as List<dynamic>?)!.length;
        post.isLike = (postJson['like'] as List<dynamic>?)!.contains(myId);
        // post.numberComment = await _getNumberComment(docPost);
        docPost.reference.collection('comments').get().then((commentSnapshot) {
          post.numberComment = commentSnapshot.docs.length;
        });

        //Load UserOverview
        tasks.add(userCollection.doc(postJson['creatorId']).get().then(
          (docUser) {
            post.creator =
                UserOverview.fromJson(docUser.data() as Map<String, dynamic>);
            post.creator.id = docUser.id; //Set doc id
          },
        ));

        post.id = docPost.id; //Set doc id
        return post;
      }).toList();
    });

    await Future.wait(tasks);
    return posts;
  }

  @override
  Future<void> update(Post entity) {
    return collection
        .doc(entity.id)
        .update(entity.toJson())
        .then((value) => print('Update ${entity.toString()} success'));
  }

  @override
  Future<void> likePost(String postId, bool isLike) {
    return collection.doc(postId).get().then((doc) {
      final json = doc.data() as Map<String, dynamic>;
      final usersLike =
          (json['like'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              <String>[];
      final myId = '7hKHP4tpuIyeTJ44IdJe';

      if (usersLike.contains(myId) && !isLike) {
        //Unlike
        doc.reference.update(<String, dynamic>{
          'like': FieldValue.arrayRemove([myId])
        });
      } else if (!usersLike.contains(myId) && isLike) {
        //Like
        doc.reference.update(<String, dynamic>{
          'like': FieldValue.arrayUnion([myId])
        });
      }
    });
  }

  @override
  Future<List> loadNumberLike(String postId) {
    final myId = '7hKHP4tpuIyeTJ44IdJe';
    return collection.doc(postId).get().then((doc) {
      final list =
          ((doc.data() as Map<String, dynamic>)['like'] as List<dynamic>)
              .map((element) => element as String)
              .toList();
      int number = list.length;
      bool isLike = list.contains(myId);
      return [number, isLike];
    });
  }

  @override
  Future<List<Post>> loadPostsFromCreator(
      UserOverview creator, int startIndex, int number) {
    return collection
        .where('creatorId', isEqualTo: creator.id)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        final json = doc.data() as Map<String, dynamic>;
        final post = Post.fromJson(json);
        post.creator = creator;
        post.id = doc.id;
        return post;
      }).toList();
    });
  }

  @override
  Future<List<String>> loadImages(String postId) {
    return collection.doc(postId).get().then((doc) {
      final json = doc.data() as Map<String, dynamic>;
      final images = (json['imagesUri'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[];

      return images;
    });
  }
}
