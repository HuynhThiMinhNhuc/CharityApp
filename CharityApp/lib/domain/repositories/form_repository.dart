import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/entities/form_register.dart';
import 'package:charityapp/domain/entities/user_overview.dart';

abstract class IFormRepository {
  Future<void> register(FormRegister form);
  Future<String> unRegister(String eventId, String userId);
  Future<void> confirm(String formId, bool isTrue);
  Future<FormRegister> load(String eventId, String userId);

  Future<List<String>> loadEventPendingFrom(String userId);
  Future<List<UserOverview>> loadPaticipantsOf(String eventId);
  Future<List<UserOverview>> loadRegisterOf(String eventId);
  Future<int> getNumberForm(String eventId);

}