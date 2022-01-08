import 'dart:async';

import 'package:async/async.dart';
import 'package:charityapp/core/helper/uploadImage_firestorage.dart';
import 'package:charityapp/domain/repositories/event_repository.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:charityapp/repositories/event_repository_imp.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:charityapp/views/bloc/post_bloc/post_event.dart';
import 'package:charityapp/views/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final IPostRepository postRepository = PostRepositoryImp();
  final IEventRepository eventRepository = EventRepositoryImp();
  // StreamSubscription? _postsSubscription;
  CancelableOperation? loadPostOperation;

  PostBloc() : super(PostLoadInProgress()) {
    on<LoadEventPosts>(_onLoadPosts);
    on<LoadRandomPosts>(_onLoadRandomPosts);
    on<LoadProfilePosts>(_onLoadProfilePosts);
    on<AddPost>(_onAddPost);
    on<DeletePost>(_onDeletePost);
    on<LoadOverViewEventsPaticipant>(_onLoadOverviewPosts);
  }

  FutureOr<void> _onLoadPosts(
      LoadEventPosts event, Emitter<PostState> emit) async {
    emit(PostLoadInProgress());

    if (loadPostOperation != null && !loadPostOperation!.isCompleted)
      loadPostOperation!.cancel();

    final task = postRepository.load(
      event.eventId,
      event.startIndex,
      event.number,
    );
    loadPostOperation = CancelableOperation.fromFuture(task);

    final posts = await task;
    emit(PostsLoadSuccess(posts: posts));
  }

  FutureOr<void> _onLoadRandomPosts(
      LoadRandomPosts event, Emitter<PostState> emit) async {
    emit(PostLoadInProgress());
    if (loadPostOperation != null && !loadPostOperation!.isCompleted)
      loadPostOperation!.cancel();

    final task = postRepository.loadRandomPosts(event.startIndex, event.number);
    loadPostOperation = CancelableOperation.fromFuture(task);

    final posts = await task;
    emit(PostsLoadSuccess(posts: posts));
  }

  void _onAddPost(AddPost event, Emitter<PostState> emit) async {
    //Add image to fire storage
    event.post.imagesUri = <String>[];
    final imagesTask = <Future<String?>>[];

    event.images.forEach((imageFile) {
      imagesTask.add(UploadImageToFirestorage.call(
              imageFile: imageFile, rootPath: 'images/posts')
          .then((uri) {
        event.post.imagesUri.add(uri);
      }).onError((error, stackTrace) {
        print('Fail to upload image to storage');
        emit(PostLoadFailure());
        return;
      }));
    });
    await Future.wait(imagesTask);

    //Save to database
    try {
      await this.postRepository.add(event.post);
      emit(PostUpdated(post: event.post));
    } catch (_) {
      emit(PostLoadFailure());
    }
  }

  void _onDeletePost(DeletePost event, Emitter<PostState> emit) {
    this.postRepository.delete(event.post.id!);
  }

  FutureOr<void> _onLoadOverviewPosts(
      LoadOverViewEventsPaticipant event, Emitter<PostState> emit) async {
    emit(PostLoadInProgress());
    final events =
        await this.eventRepository.loadEventsPaticipant(event.creatorId);
    emit(PostsLoadOverviewSuccess(eventsOverview: events));
  }

  FutureOr<void> _onLoadProfilePosts(
      LoadProfilePosts event, Emitter<PostState> emit) async {
    emit(PostLoadInProgress());
    if (loadPostOperation != null && !loadPostOperation!.isCompleted)
      loadPostOperation!.cancel();

    final task = postRepository.loadPostsFromCreator(
      event.creator,
      event.startIndex,
      event.number,
    );
    loadPostOperation = CancelableOperation.fromFuture(task);

    final posts = await task;
    emit(PostsLoadSuccess(posts: posts));
  }
}
