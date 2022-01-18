import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:library_app/Router/Routes.dart';
import 'package:library_app/Router/router.dart';
import 'package:library_app/models/book.dart';
import 'package:library_app/repositories/book_repository.dart';
import 'package:library_app/repositories/i_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
          'CREATE TABLE books(id INTEGER PRIMARY KEY, title, pages)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    ),
  );
});

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AsyncValue<Repository> booksRepository = ref.watch(booksRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Application.router.navigateTo(context, Routes.newBook,
              transition: TransitionType.material);
        },
      ),
    );
  }
}

//   padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
//   child: ListView.builder(
//     itemBuilder: (context, index) => BookCard(
//         title: dummyBooks[index]['title'] as String,
//         authors: dummyBooks[index]['author'] as List<String>),
//   ),
// ),
class BookCard extends StatelessWidget {
  final Book data;

  const BookCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String authorsString =
    //     data.authors.length > 1 ? data.authors.join(', ') : data.authors[0];

    return Container(
      constraints: const BoxConstraints(maxHeight: 450),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
          child: Column(
            children: [
              // Expanded(
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(12.0),
              //     child: Image.network(data.imageUrl),
              //   ),
              // ),
              const SizedBox(height: 8.0),
              Text(
                data.title,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                    color: Theme.of(context).textTheme.headline1?.color),
              ),
              const SizedBox(height: 8.0),
              // Text(
              //   authorsString,
              //   style: TextStyle(
              //     fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
              //     color: Theme.of(context).textTheme.headline1?.color,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
