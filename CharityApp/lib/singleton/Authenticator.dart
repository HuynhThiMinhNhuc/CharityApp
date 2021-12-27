import 'package:charityapp/repositories/user_repository_imp.dart';

class Authenticator{
  UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  String idCurrentUser = "7hKHP4tpuIyeTJ44IdJe";

  bool login(String email, String pass){
      idCurrentUser = userRepositoryImp.getIdUser(email, pass) as String;
      if (idCurrentUser.length > 0) return true;
      else return false;
    }
  }