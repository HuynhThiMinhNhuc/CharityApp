import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IUserRepository implements CRUDableRepository<UserProfile>{
  Future<UserOverview> loadFriends(String ofUserId, int number);
  Future<int> getIdUser(String username, String pass);
  Future<UserProfile> getUserProfile(String id);
  Future<List<Post>> getListPost(String id);
}