import 'package:charityapp/domain/entities/user_infor.dart';
import 'package:charityapp/domain/entities/user_overview.dart';

abstract class IActiveUserRepository {
  Future<List<UserOverview>> loadActiveUser();
  Future<void> addActiveUser(String id);
  Future<void> deleteActiveUser(String id);
}

