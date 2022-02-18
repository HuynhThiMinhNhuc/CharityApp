abstract class IEmailReposity {
  Future<bool> emailAlreadyExist(String email);
  Future<void> addEmail(String email);
}
