abstract class Repository<T, New, ID> {
  getAll();

  getById(ID id);

  Future<ID> insert(New entity);

  Future<ID> update(T entity);

  delete(ID id);
}
