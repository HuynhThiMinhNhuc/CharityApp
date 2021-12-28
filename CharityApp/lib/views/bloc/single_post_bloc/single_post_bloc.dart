import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:charityapp/views/bloc/single_post_bloc/single_post.dart';

class SinglePostBloc extends Bloc<SinglePostEvent, SinglePostState> {
  IPostRepository repository = PostRepositoryImp();

  SinglePostBloc() : super(SinglePostUpdated()) {
    on<LikeSinglePost>(_onLikePost);
  }
  

  FutureOr<void> _onLikePost(LikeSinglePost event, Emitter<SinglePostState> emit) {
    emit(SinglePostInProccess());
    repository.likePost(event.postId, event.isLike);
    emit(SinglePostUpdated());
  }
}
