import 'dart:async';

import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:charityapp/views/bloc/post_bloc/post_event.dart';
import 'package:charityapp/views/bloc/post_bloc/post_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepositoryImp postRepository;
  StreamSubscription? _postsSubscription;

  PostBloc({required this.postRepository}) : super(PostsLoadInProgress()) {
    on<LoadPosts>(_onLoadPosts);
    on<AddPost>(_onAddPost);
    on<DeletePost>(_onDeletePost);
    on<PostsUpdated>(_onPostsUpdated);
  }

  void _onLoadPosts(LoadPosts event, Emitter<PostState> emit) {
    _postsSubscription?.cancel();
      _postsSubscription = this.postRepository.load(event.eventId, event.startIndex, event.number).listen((posts) {
        add(PostsUpdated(eventId: event.eventId, posts: posts));
      });
  }

  void _onAddPost(AddPost event, Emitter<PostState> emit) {
    this.postRepository.add(event.post);
  }

  void _onDeletePost(DeletePost event, Emitter<PostState> emit) {
    this.postRepository.delete(event.post.id);
  }

  void _onPostsUpdated(PostsUpdated event, Emitter<PostState> emit) {
    emit(PostsLoadSuccess(posts: event.posts));
  }
}
