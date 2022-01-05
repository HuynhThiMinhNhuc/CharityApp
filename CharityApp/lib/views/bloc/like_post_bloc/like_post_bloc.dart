import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import './like_post.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  IPostRepository repository = PostRepositoryImp();

  LikePostBloc() : super(PostNumberLike(numberLike: 0, numberComment: 0, isLike: false)) {
    on<LikePost>(_onLikePost);
    on<GetNumberLike>(_onGetNumberLike);
  }
  

  FutureOr<void> _onLikePost(LikePost event, Emitter<LikePostState> emit) async {
    await repository.likePost(event.postId, event.isLike);
    // add(GetNumberLike(postId: event.postId));
  }

  FutureOr<void> _onGetNumberLike(GetNumberLike event, Emitter<LikePostState> emit) async{
    final values = await repository.loadNumberLike(event.postId);
    emit(PostNumberLike(id: event.postId, numberLike: values[0], isLike: values[1], numberComment: values[2]));
  }
}
