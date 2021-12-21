import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class UserRepositoryImp implements IUserRepository{
  final user = FirebaseFirestore.instance.collection("users");

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
    int id = 0;
     await for ( var snapshot in user
         .where("Name", isEqualTo: username)
         .where("Password", isEqualTo: pass).snapshots()){
       id  = snapshot.docs[0].data()['Id'];
     }
     return id;
  }

  @override
  Future<UserProfile> getUserProfile(int id) async {
    var userinfo;
    await user.doc(id.toString()).get().then((value){
      userinfo = value.data();
    });
    return new UserProfile(name: userinfo!['Name'], description: userinfo!["Description"], gender: userinfo!['Gender'] == 0? Genders.Female :userinfo!['Gender'] == 1? Genders.Male : Genders.Undefined ,birthDayString: "17/02/2001", avatarUri: null );
  }

  @override
  Future<List<Post>> getListPost(int id) {
    // TODO: implement getListPost
    throw UnimplementedError();
  }
}