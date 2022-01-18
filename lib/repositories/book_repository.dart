import 'dart:async';

import 'package:library_app/db/models/new_book.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/repositories/i_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLBookRepository extends Repository<Book, NewBook, int> {
  final Database _database;

  SQLBookRepository(this._database);

  @override
  delete(int id) async {
    _database.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<Book>> getAll() async {
    return _database.query('books').then((rows) {
      return rows.map((row) => Book.fromMap(row)).toList();
    });
  }

  @override
  Future<Book> getById(int id) async {
    return _database
        .query('books', where: 'id = ?', whereArgs: [id]).then((rows) {
      return rows.map((row) => Book.fromMap(row)).toList().first;
    });
  }

  @override
  Future<int> insert(NewBook newBook) async {
    Map<String, Object> bookMap = {
      'title': newBook.title,
      'pages': newBook.pages,
    };

    int? newBookId;

    if (newBook.image != null) {
      await _database.transaction((txn) async {
        var imageData = newBook.image!;
        Map<String, Object?> imageMap = {
          'data': imageData.imageData,
          'mimeType': imageData.mimeType,
          'title': imageData.title,
        };

        var imageId = await txn.insert('images', imageMap);
        bookMap['image_id'] = imageId;
        newBookId = await txn.insert('books', bookMap);
      });
    }

    newBookId = await _database.insert('books', bookMap);
    return Future.value(newBookId);
  }

  @override
  Future<int> update(Book entity) async {
    return _database.update('books', entity.toMap(),
        where: 'id = ?', whereArgs: [entity.id]);
  }
}
