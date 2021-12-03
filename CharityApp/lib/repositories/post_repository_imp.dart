import 'package:charityapp/domain/entities/user_comment.dart';
import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/repositories/post_repository.dart';

class PostRepositoryImp implements IPostRepository{
  @override
  Future<void> add(Post entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Post> load(String id) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future<List<UserComment>> loadComments(String id, int number) {
    // TODO: implement loadComments
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id) {
    // TODO: implement update
    throw UnimplementedError();
  }
  
}