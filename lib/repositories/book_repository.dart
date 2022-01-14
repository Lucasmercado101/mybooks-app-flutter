import 'package:library_app/models/book.dart';
import 'package:library_app/repositories/i_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLBookRepository extends Repository<Book, int> {
  final Database _db;

  SQLBookRepository._(this._db);

  static init() async {
    openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'books_read_app.db'),
      singleInstance: true,
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE books(id INTEGER PRIMARY KEY, title, pages)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  @override
  delete(int id) {
    _db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Book>> getAll() {
    return _db.query('books').then((rows) {
      return rows.map((row) => Book.fromMap(row)).toList();
    });
  }

  @override
  Future<Book> getById(int id) {
    return _db.query('books', where: 'id = ?', whereArgs: [id]).then((rows) {
      return rows.map((row) => Book.fromMap(row)).toList().first;
    });
  }

  @override
  Future<int> insert(Book entity) {
    return _db.insert('books', entity.toMap());
  }

  @override
  Future<int> update(Book entity) {
    return _db.update('books', entity.toMap(),
        where: 'id = ?', whereArgs: [entity.id]);
  }
}
