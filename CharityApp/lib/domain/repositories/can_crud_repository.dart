abstract class CRUDableRepository<T> {
  Stream<T> load(String id);
  Future<void> add(T entity);
  Future<void> delete(String id);
  Future<void> update(T id);
}