import 'package:bloc/bloc.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:equatable/equatable.dart';


class NumberLikeCubit extends Cubit<int> {
  IPostRepository repository = PostRepositoryImp();

  NumberLikeCubit() : super(0);

  void load(String postId) async{
    emit(await repository.loadNumberLike(postId));
  }
  void like(String postId, bool isLike) {
    repository.likePost(postId, isLike);
    emit(state + (isLike? 1 : -1));
  }
}
