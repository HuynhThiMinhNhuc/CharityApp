import 'package:bloc/bloc.dart';
import 'package:charityapp/core/helper/infinity_list.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';
import 'package:charityapp/repositories/post_repository_imp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:infinite_listview/infinite_listview.dart';
import 'package:meta/meta.dart';

class ListPostHomeCubit extends Cubit<InfinityListController<Post>> {
  final IPostRepository postRepository = PostRepositoryImp();
  ListPostHomeCubit()
      : super(InfinityListController<Post>(items: <Post>[]));

  void fetchList({int startIndex = 0, int number = 0}) async {
    //Loading
    // emit(state.copyWith(status: InfinityListStatus.loading));
    try {
      final task = postRepository.loadRandomPosts(startIndex, number);
      final posts = await state.load(task);
      //Success
      emit(state.copyWith(items: posts, status: InfinityListStatus.success));
    } on Exception catch (e) {
      //Error
      emit(state.copyWith(status: InfinityListStatus.failure));
    }
  }
}
