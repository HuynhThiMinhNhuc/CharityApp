import 'package:charityapp/domain/entities/tag_event.dart';
import 'package:charityapp/domain/repositories/can_crud_repository.dart';

abstract class ITagEventRepository {
  Future<List<TagEvent>> loadTags();
  Future<List<TagEvent>> loadFrom(String eventId);
}