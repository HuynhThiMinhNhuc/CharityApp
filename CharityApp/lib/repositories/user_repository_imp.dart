import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserRepositoryImp implements IUserRepository{

  @override
  Future<void> add(UserInfor entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<UserProfile> load(String id) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future<UserOverview> loadFriends(String id, int number) {
    // TODO: implement loadFriend
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}