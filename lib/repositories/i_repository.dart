abstract class Repository<StoredEntity, NewEntity, ID> {
  Future<List<StoredEntity>> getAll();

  Future<StoredEntity> getById(ID id);

  Future<ID> insert(NewEntity entity);

  Future<ID> update(StoredEntity entity);

  Future delete(ID id);
}
