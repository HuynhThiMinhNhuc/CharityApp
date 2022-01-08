abstract class ITagRepository {
  Future<List<String>> load();
  Future<List<String>> loadFrom(String eventId);
}