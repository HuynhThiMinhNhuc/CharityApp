import 'package:charityapp/domain/entities/tag_event.dart';

abstract class ITagEventRepository {
  Future<List<TagEvent>> loadTags();
  Future<List<TagEvent>> loadFrom(String eventId);
}
