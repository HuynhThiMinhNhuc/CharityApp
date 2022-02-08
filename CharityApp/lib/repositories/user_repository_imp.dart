import 'package:charityapp/domain/entities/post.dart';
import 'package:charityapp/domain/entities/user_overview.dart';
import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/domain/repositories/user_repository.dart';
import 'package:charityapp/singleton/Authenticator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tiengviet/tiengviet.dart';

class UserRepositoryImp implements IUserRepository {
  final userCollection = FirebaseFirestore.instance.collection("users");

  @override
  Future<List<UserOverview>> loadFriends(String id, int number) async {
    List<UserOverview> friends = [];
    UserOverview useroverview;
    try {
      await userCollection.doc(id).get().then((value) async {
        for (var element in List.from(value.data()!['friends'])) {
          if (element != id) {
            useroverview = await getUserOverView(element);
            friends.add(useroverview);
          }
        }
        ;
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
      await userCollection
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
    userCollection
        .doc(userProfile.id)
        .get()
        .then((value) => value.reference.update(data));
  }

  @override
  Future<String> getIdUser(String email) async {
    String id = "";
    try {
      await userCollection.where("email", isEqualTo: email).get().then((value) {
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
    await userCollection.doc(id).get().then((value) {
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

    await userCollection.doc(id).get().then((value) {
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
    String id = GetIt.instance.get<Authenticator>().userProfile.id!;
    try {
      await userCollection.get().then((value) {
        for (var user in value.docs) {
          if (user.id != id &&
              (search == "" ||
                  TiengViet.parse(user['name'].toString().toLowerCase())
                      .contains(TiengViet.parse(search.toLowerCase())))) {
            userOverview = new UserOverview(
                name: user['name'], avatarUri: user['avatarUri'], id: user.id);
            suggesstion.add(userOverview);
          }
        }
      });
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
      await userCollection
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
      await userCollection
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
      await userCollection
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
    userCollection
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
          'numberfollower': 0,
          'avatarUri': ""
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

  @override
  Future<List<String?>> loadAvatarUriPaticipant(String eventId,
      [int number = 5]) async {
    final paticipantCollection =
        FirebaseFirestore.instance.collection('event_paticipants');
    final listUserId = await paticipantCollection
        .where('eventId', isEqualTo: eventId)
        .limit(number)
        .get()
        .then((snapshot) {
      return snapshot.docs.map((doc) {
        return (doc.data())['userId'];
      }).toList();
    });

    if (listUserId.isNotEmpty) {
      return userCollection
          .where(FieldPath.documentId, whereIn: listUserId)
          .get()
          .then((snapshot) {
        return snapshot.docs
            .map((doc) => (doc.data())['avatarUri'] as String?)
            .toList();
      });
    } else
      return [];
  }

  Future<void> updateNumberFollowing(bool isincrease, String id) async {
    int number = 0;
    try {
      await userCollection
          .doc(id)
          .get()
          .then((value) => number = value.data()!['numberfollower']);
      await userCollection
          .doc(id)
          .update({"numberfollower": isincrease ? (number + 1) : (number - 1)});
    } catch (e) {
      print("Error update number following:" + e.toString());
    }
  }

  @override
  Future<List<UserOverview>> getUsersOfEvent(
      String eventId, int startIndex, int number) async {
    final paticipantsCollection =
        FirebaseFirestore.instance.collection('event_paticipants');

    final paticipantSnapshot =
        await paticipantsCollection.where('eventId').get();

    final users = paticipantSnapshot.docs.map((paticipantDoc) async {
      String userId = paticipantDoc.data()['userId'] as String;

      final userDoc = await userCollection.doc(userId).get();
      final userJson = userDoc.data() as Map<String, dynamic>;

      return UserOverview.fromJson(userJson);
    }).toList();

    return Future.wait(users);
  }

  @override
  Future<List<UserOverview>> loadOverviewFormList(
      List<String> listUserId) async {
    if (listUserId.isNotEmpty) {
      return userCollection
          .where(FieldPath.documentId, whereIn: listUserId)
          .get()
          .then((snapshot) {
        return snapshot.docs.map((doc) {
          final json = doc.data() as Map<String, dynamic>;

          return UserOverview.fromJson(json)..id = doc.id;
        }).toList();
      });
    } else
      return [];
  }

  @override
  Future<List<UserOverview>>? getHistory(String id) {
    List<UserOverview> historyfriend = [];
    userCollection.doc(id).get().then((value) async {
      if (value.exists) {
        List<String> history = [];
        history = List.from(value.data()!['history']);
        for (int i = 0; i < history.length; ++i) {
          var user = await getUserOverView(history[i]);
          historyfriend.add(user);
        }
        return historyfriend;
      } else {
        return null;
      }
    });
    return null;
  }
}
