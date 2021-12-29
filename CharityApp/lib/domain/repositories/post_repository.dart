import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IPostRepository implements CRUDableRepository<Post>{
  Future<List<Post>> loadRandomPosts(int startIndex, int number);

  Future<void> likePost(String postId, bool isLike);

  Future<int> loadNumberLike(String postId);
}