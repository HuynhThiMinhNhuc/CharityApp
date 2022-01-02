import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/views/Login/register_view.dart';

class Authenticator {
  UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  var userProfile;

  Future<void> login(String email) async {
    String id = await userRepositoryImp.getIdUser(email);
    userProfile = await userRepositoryImp.getUserProfile(id);
  }
}
