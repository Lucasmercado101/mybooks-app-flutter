abstract class Repository<T, ID> {
  Future<List<T>> getAll();

  Future<T> getById(ID id);

  Future<ID> insert(T entity);

  Future<ID> update(T entity);

  delete(ID id);
}
