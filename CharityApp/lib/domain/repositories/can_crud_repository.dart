abstract class CRUDableRepository<T> {
  Stream<List<T>> load(String id, int startIndex, int number);
  Future<void> add(T entity);
  Future<void> delete(String id);
  Future<void> update(T entity);
}