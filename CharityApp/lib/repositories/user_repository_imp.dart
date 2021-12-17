import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
class UserRepositoryImp implements IUserRepository{
  final user = FirebaseFirestore.instance.collection("USER");

  @override
  Future<void> add(UserInfor userInfor) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Stream<List<UserProfile>> load(String id, int startIndex, int number) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Stream<UserOverview> loadFriends(String id, int number) {
    // TODO: implement loadFriend
    throw UnimplementedError();
  }

  @override
  Future<void> update(UserInfor id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<int> getIdUser(String username, String pass) async {
     var value =  await user
         .where("Name", isEqualTo: username)
         .where("Password", isEqualTo: pass)
         .get().then((value) => value);
     return value.docs[0].get("Id");
  }

  @override
  Future<UserProfile> getUserProfile(int id) async {
    throw UnimplementedError();

    // var value = await user.where("Id", isEqualTo: id).get().then((value) => value);
    // return new UserProfile(name: value.docs[0].get("name"), avatarUri: value.docs[0].get("Avatar"), description: value.docs[0].get("Description"), gender: value.docs[0].get("Gender"), birthDayString: value.docs[0].get("Birthday") );
  }

  @override
  Future<List<Post>> getListPost(int id) {
    // TODO: implement getListPost
    throw UnimplementedError();
  }

}