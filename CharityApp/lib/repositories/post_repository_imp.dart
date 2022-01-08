import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:charityapp/repositories/tag_event_repository_imp.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

class PostRepositoryImp implements IPostRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection("posts");

  @override
  Future<void> add(Post entity) async {
    final docRef = await collection.add(
        entity.toJson()..addAll({'timeCreate': DateTime.now(), 'like': []}));
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
      return snapshot.docs.map((docPost) async {
        final postJson = docPost.data() as Map<String, dynamic>;
        final post = Post.fromJson(postJson);
        post.id = docPost.id; //Set doc id

        final tagRepo = TagEventRepositoryImp();
        final tags = (await tagRepo.loadFrom(post.eventId!));
        post.tags = tags.map((tag) => tag.name).toList();

        //Load UserOverview
        await userCollection.doc(postJson['creatorId']).get().then(
          (docUser) {
            post.creator =
                UserOverview.fromJson(docUser.data() as Map<String, dynamic>);
            post.id = docUser.id; //Set doc id
          },
        );

        return post;
      }).toList();
    });

    // await Future.wait(tasks);
    return await Future.wait(posts);
  }

  @override
  Future<List<Post>> loadRandomPosts(int startIndex, int number) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    List<Future> tasks = <Future>[];

    final posts = await collection
        .orderBy('timeCreate', descending: true)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((docPost) async {
        final postJson = docPost.data() as Map<String, dynamic>;
        final post = Post.fromJson(postJson)..id = docPost.id;
        // final list = await loadNumberLike(docPost.id);

        // post.numberLike = list[0]; //(postJson['like'] as List<dynamic>?)?.length ?? 0;
        // post.isLike = list[1];
        // post.numberComment = list[2];
        // (postJson['like'] as List<dynamic>?)?.contains(Authenticator.Id) ??
        //     false;
        // post.numberComment = await _getNumberComment(docPost);
        // docPost.reference.collection('comments').get().then((commentSnapshot) {
        //   post.numberComment = commentSnapshot.docs.length;
        // });

        final tagRepo = TagEventRepositoryImp();
        final tags = (await tagRepo.loadFrom(post.eventId!));
        post.tags = tags.map((tag) => tag.name).toList();

        //Load UserOverview
        await userCollection.doc(postJson['creatorId']).get().then(
          (docUser) {
            post.creator =
                UserOverview.fromJson(docUser.data() as Map<String, dynamic>);
            post.creator.id = docUser.id; //Set doc id
          },
        );

        return post;
      }).toList();
    });

    // await Future.wait(tasks);
    return await Future.wait(posts);
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

      if (usersLike.contains(Authenticator.Id) && !isLike) {
        //Unlike
        doc.reference.update(<String, dynamic>{
          'like': FieldValue.arrayRemove([Authenticator.Id])
        });
      } else if (!usersLike.contains(Authenticator.Id) && isLike) {
        //Like
        doc.reference.update(<String, dynamic>{
          'like': FieldValue.arrayUnion([Authenticator.Id])
        });
      }
    });
  }

  @override
  Future<List> loadNumberLike(String postId) {
    return collection.doc(postId).get().then((doc) async {
      final json = doc.data() as Map<String, dynamic>;
      final list = (json['like'] as List<dynamic>?)
              ?.map((element) => element as String)
              .toList() ??
          [];
      int numberComment =
          (await doc.reference.collection('comments').get()).docs.length;
      int numberLike = list.length;
      bool isLike = list.contains(Authenticator.Id);
      return [numberLike, isLike, numberComment];
    });
  }

  @override
  Future<List<Post>> loadPostsFromCreator(
      UserOverview creator, int startIndex, int number) async {
    final listPost = await collection
        .where('creatorId', isEqualTo: creator.id)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) async {
        final json = doc.data() as Map<String, dynamic>;
        final post = Post.fromJson(json)..id = doc.id;
        post.creator = creator;

        final tagRepo = TagEventRepositoryImp();
        final tags = (await tagRepo.loadFrom(post.eventId!));
        post.tags = tags.map((tag) => tag.name).toList();

        return post;
      }).toList();
    });

    return await Future.wait(listPost);
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
