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
  Future<List<UserProfile>> load(String id, int startIndex, int number) {
    // TODO: implement load
    throw UnimplementedError();
  }

  @override
  Future<UserOverview> loadFriends(String id, int number) {
    // TODO: implement loadFriend
    throw UnimplementedError();
  }

  @override
  Future<void> update(UserProfile userProfile) async {
    Map<String,dynamic> data = {
        'id' : userProfile.id,
        'avatarUri' : userProfile.avatarUri,
        "birthday" : userProfile.birthDayString,
        'description': userProfile.description,
        'gender' : userProfile.gender ==  Genders.Female? 1: userProfile.gender == Genders.Male? 0: 2,
        'name': userProfile.name,
        'phone':userProfile.phone,
        'email':userProfile.email,
        'password':userProfile.password,
        };
    user.doc(userProfile.id).get().then((value) => value.reference.update(data));
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
  Future<UserProfile> getUserProfile(String id) async {
    var userinfo;

    await user.doc(id).get().then((value) {
      userinfo = value.data()!;
    });
    UserProfile userProfile = new UserProfile(
        name: userinfo['name'],
        description: userinfo["description"],
        gender: userinfo['gender'] == 0
            ? Genders.Female
            : userinfo['gender'] == 1
                ? Genders.Male
                : Genders.Undefined,
        birthDayString: "17/02/2001",
        avatarUri: null,
        id: id, 
        email: userinfo['email'], 
        password: userinfo['password'], 
        phone: userinfo['phone']);
    return userProfile;
  }

  @override
  Future<List<Post>> getListPost(String id) {
    // TODO: implement getListPost
    throw UnimplementedError();
  }
}