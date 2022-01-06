import 'package:charityapp/domain/entities/user_profile.dart';
import 'package:charityapp/repositories/user_repository_imp.dart';
import 'package:get_it/get_it.dart';

class Authenticator {
  UserRepositoryImp userRepositoryImp = new UserRepositoryImp();
  late UserProfile userProfile;
  static String get Id => GetIt.instance.get<Authenticator>().userProfile.id!;
  static UserProfile get profile => GetIt.instance.get<Authenticator>().userProfile;

  Future<void> login(String email) async {
    String id = await userRepositoryImp.getIdUser(email);
    userProfile = await userRepositoryImp.getUserProfile(id);
  }
}
