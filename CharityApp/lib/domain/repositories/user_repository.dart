import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';

abstract class IUserRepository {
  Future<List<UserOverview>> loadFriends(String ofUserId, int number);
  Future<List<UserOverview>> loadOverviewFormList(List<String> userIds);
  Future<int> loadNumberFriends(String ofUserId);
  Future<String> getIdUser(String email);
  Future<UserProfile> getUserProfile(String id);
  Future<List<Post>> getListPost(String id);
  Future<List<UserOverview>> searchUser(String query);
  Future<List<UserOverview>> getUsersOfEvent(
      String eventId, int startIndex, int number);
  Future<bool> isFriend(String id);
  Future<void> follow(String? id);
  Future<void> unfollow(String? id);
  Future<void> changepassword(String newpass);
  Future<void> resetpassword(String newpass);
  Future<List<String?>> loadAvatarUriPaticipant(String eventId);
  Future<void> updateNumberFollowing(bool isincrease, String id);
  Future<List<UserOverview>>? getHistory(String id);
  Future<void> updateHistory(String id, String idSearch);
}
