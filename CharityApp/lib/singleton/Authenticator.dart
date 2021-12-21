import 'package:charityapp/repositories/user_repository_imp.dart';

class Authenticator{
  UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  int idCurrentUser = 0;

  bool login(String username, String pass){
      idCurrentUser = userRepositoryImp.getIdUser(username, pass) as int;
      if (idCurrentUser > 0) return true;
      else return false;
    }
  }