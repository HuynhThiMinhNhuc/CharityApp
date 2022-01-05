import 'package:charityapp/domain/entities/event_overview.dart';
import 'package:charityapp/domain/entities/event_overview_paticipant.dart';
import 'package:charityapp/domain/entities/form_register.dart';

abstract class IFormRepository {
  Future<void> register(FormRegister form);
  Future<void> unRegister(String eventId, String userId);
  Future<void> confirm(String formId, bool isTrue);
  Future<List<String>> loadEventPendingFrom(String userId);
}