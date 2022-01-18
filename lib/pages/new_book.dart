import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_app/db/models/new_book.dart';
import 'package:library_app/repositories/book_repository.dart';
import 'package:library_app/repositories/i_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:image_picker/image_picker.dart';

final booksRepositoryProvider = FutureProvider<Repository>((ref) async {
  return SQLBookRepository(
    await openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'books_read_app.db'),
      singleInstance: true,
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          """CREATE TABLE books(id INTEGER PRIMARY KEY, title, pages, image_id);
          CREATE TABLE 
          images(
            id INTEGER PRIMARY KEY,
            mime_type TEXT,
            title TEXT, 
            data BLOB);
          """,
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    ),
  );
});

class NewBookPage extends ConsumerStatefulWidget {
  const NewBookPage({Key? key}) : super(key: key);

  @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends ConsumerState<NewBookPage> {
  String _title = "";
  String _pages = "";
  XFile? _image;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var booksRepository = ref.watch(booksRepositoryProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text("New Book"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onChanged: (value) {
                  _title = value;
                },
              ),
              // TextFormField(
              //   decoration: const InputDecoration(
              //     labelText: "Author",
              //   ),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null;
              //   },
              //   onSaved: (value) {
              //     _title = value;
              //   },
              // ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Pages",
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  return null;
                },
                onChanged: (value) {
                  _pages = value;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    final ImagePicker _picker = ImagePicker();
                    _image =
                        await _picker.pickImage(source: ImageSource.gallery);
                  },
                  child: const Text("Add Image")),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    booksRepository!.insert(NewBook(
                      title: _title,
                      pages: int.parse(_pages),
                    ));
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
