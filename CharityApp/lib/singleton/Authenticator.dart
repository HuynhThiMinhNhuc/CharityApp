import 'package:charityapp/repositories/user_repository_imp.dart';

class Authenticator{
  UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  String idCurrentUser = "1G0aTSj46pSsvP8eBYb5";

  bool login(String username, String pass){
      idCurrentUser = userRepositoryImp.getIdUser(username, pass) as String;
      if (idCurrentUser.length > 0) return true;
      else return false;
    }
  }