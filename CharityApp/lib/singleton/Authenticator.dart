import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:charityapp/views/Login/register_view.dart';

class Authenticator {
  UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  String idCurrentUser = "";
  String email = "";

  Future<bool> login(String email) async {
    idCurrentUser = await userRepositoryImp.getIdUser(email);
    if (idCurrentUser.length > 0) {
      this.email = email;
      return true;
    } else
      return false;
  }
}
