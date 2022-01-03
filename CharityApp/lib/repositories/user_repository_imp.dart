import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/domain/repositories/user_repository.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tiengviet/tiengviet.dart';

class UserRepositoryImp implements IUserRepository {
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
  Future<List<UserOverview>> loadFriends(String id, int number) async {
    List<UserOverview> friends = [];
    UserOverview useroverview;

    try {
      await user.doc(id).get().then((value) {
        List.from(value.data()!['friends']).forEach((element) async {
          useroverview = await getUserOverView(element);
          useroverview.id = element;
          friends.add(useroverview);
        });
      });
      return friends;
    } catch (e) {
      print("Lỗi load danh sách bạn bè" + e.toString());
      return friends;
    }
  }

  @override
  Future<int> loadNumberFriends(String id) async {
    int number = 0;
    try {
      await user
          .doc(id)
          .get()
          .then((value) => number = List.from(value.data()!['friends']).length);
      return number;
    } catch (e) {
      print("Load số lượng bạn bè thất bại");
      return number;
    }
  }

  @override
  Future<void> update(UserProfile userProfile) async {
    Map<String, dynamic> data = {
      'id': userProfile.id,
      'avatarUri': userProfile.avatarUri,
      "birthday": userProfile.birthDayString,
      'description': userProfile.description,
      'gender': userProfile.gender == Genders.Female
          ? 1
          : userProfile.gender == Genders.Male
              ? 0
              : 2,
      'name': userProfile.name,
      'phone': userProfile.phone,
      'email': userProfile.email,
    };
    user
        .doc(userProfile.id)
        .get()
        .then((value) => value.reference.update(data));
  }

  @override
  Future<String> getIdUser(String email) async {
    String id = "";
    try {
      await user.where("email", isEqualTo: email).get().then((value) {
        id = value.docs[0].id;
      });
    } catch (e) {
      print("Lỗi lấy id người dùng: " + e.toString());
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
        name: userinfo['name'] ?? "",
        description: userinfo["description"] ?? "",
        gender: userinfo['gender'] == 0
            ? Genders.Female
            : userinfo['gender'] == 1
                ? Genders.Male
                : Genders.Undefined ?? Genders.Undefined,
        birthDayString: userinfo['birthday'],
        avatarUri: userinfo['avatarUri'],
        email: userinfo['email'],
        phone: userinfo['phone'] ?? "",
        numberPost: userinfo['numberevent'],
        numberFollower: userinfo['numberfollower'],
        id: id);
    userProfile.numberFollowing = await loadNumberFriends(id);
    return userProfile;
  }

  @override
  Future<List<Post>> getListPost(String id) {
    // TODO: implement getListPost
    throw UnimplementedError();
  }

  Future<UserOverview> getUserOverView(String id) async {
    var userinfo;

    await user.doc(id).get().then((value) {
      userinfo = value.data()!;
    });
    UserOverview userProfile = new UserOverview(
        name: userinfo['name'],
        avatarUri: userinfo['avatarUri'],
        address: userinfo['address'],
        id: id);
    return userProfile;
  }

  @override
  Future<List<UserOverview>> searchUser(String search) async {
    List<UserOverview> suggesstion = [];
    UserOverview userOverview;
    try {
      final value = await user.get().then((value) => value.docs.forEach((user) {
            if (TiengViet.parse(user['name'].toString().toLowerCase())
                .contains(TiengViet.parse(search.toLowerCase()))) {
              userOverview = new UserOverview(
                  name: user['name'],
                  avatarUri: user['avatarUri'],
                  id: user.id);
              suggesstion.add(userOverview);
            }
          }));
      return suggesstion;
    } catch (e) {
      print("Lỗi tìm kiếm: " + e.toString());
      return suggesstion;
    }
  }

  @override
  Future<bool> isFriend(String id) async {
    bool isFriend = false;

    try {
      await user
          .doc(GetIt.instance.get<Authenticator>().userProfile.id)
          .get()
          .then((value) {
        isFriend =
            List.from(value.data()!['friends']).contains(id) ? true : false;
      });
    } catch (e) {
      print("Lỗi load danh sách bạn bè" + e.toString());
    }
    return isFriend;
  }

  @override
  Future<void> follow(String? id) async {
    // final usercolection =
    //     user.doc(GetIt.instance.get<Authenticator>().idCurrentUser);
    try {
      await user
          .doc(GetIt.instance.get<Authenticator>().userProfile.id)
          .update({
            'friends': FieldValue.arrayUnion([id])
          })
          .then((value) => print("Them ban be thanh coong"))
          .catchError((onError) => print("Loi :" + onError.toString()));
    } catch (e) {
      print("Bỏ theo dõi: lỗi kết nối database" + e.toString());
    }
  }

  @override
  Future<void> unfollow(String? id) async {
    try {
      await user
          .doc(GetIt.instance.get<Authenticator>().userProfile.id)
          .update({
            'friends': FieldValue.arrayRemove([id])
          })
          .then((value) => print("Xoa thanh coong"))
          .catchError((onError) => print("Loi :" + onError.toString()));
    } catch (e) {
      print("Bỏ theo dõi: lỗi kết nối database" + e.toString());
    }
  }

  Future<void> create(UserProfile userInfor) async {
    user
        .doc(userInfor.id)
        .set({
          'email': userInfor.email,
          'name': userInfor.name,
          'birthday': userInfor.birthDayString,
          'gender': userInfor.gender == Genders.Male
              ? 0
              : userInfor.gender == Genders.Female
                  ? 1
                  : 0,
          'description': "",
          'friends': [],
          'phone': '',
          'numberevent': 0,
          'numberfollower': 0
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
    ;
  }

  @override
  Future<void> changepassword(String newpass) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      await user!.updatePassword(newpass);
    } catch (e) {
      print("Error change passsword:" + e.toString());
    }
  }
}
