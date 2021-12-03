import 'package:charityapp/domain/entities/user_infor.dart';

abstract class AuthenticationRepository {
  Future<void> Login({required String username, required String password});
  Future<void> SignUp({required String username, required String password});
  Future<void> CreateInformation({required String name, required String birthday, required String email, required Genders gender});
  Future<void> ChangePassword({required String oldPass, required String newPass});
  Future<void> SendOTP({required String phone});
  Future<void> Confirm({required String code});
}