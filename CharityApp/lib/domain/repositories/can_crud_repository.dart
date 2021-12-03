abstract class AbleCRUDRepository<T> {
  Future<T> load(String id);
  Future<void> add(T entity);
  Future<void> delete(String id);
  Future<void> update(String id);
}