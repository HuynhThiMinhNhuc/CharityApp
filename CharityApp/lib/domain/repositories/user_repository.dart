import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class IUserRepository implements AbleCRUDRepository<UserProfile>{
  Future<UserOverview> loadFriends(String id, int number);
}