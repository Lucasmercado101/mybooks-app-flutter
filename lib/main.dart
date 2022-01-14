import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:library_app/Router/routes.dart';
import 'package:library_app/Router/router.dart';
import 'package:library_app/repositories/book_repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CustomColors {
  static const Color charcoal = Color(0xFF30404F);
  static const Color independence = Color(0xFF3E4C65);
  static const Color lightYellow = Color(0xFFF2F5D5);
  static const Color chocolateWeb = Color(0xFFD16821);
  static const Color bigDipOruby = Color(0xFFA62646);
}

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }
}

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
    SQLBookRepository.init();
    // _test();
  }

  _test() async {
// Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
    WidgetsFlutterBinding.ensureInitialized();
// Open the database and store the reference.
    final database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    // Define a function that inserts dogs into the database
    Future<void> insertDog(Dog dog) async {
      // Get a reference to the database.
      final db = await database;

      // Insert the Dog into the correct table. You might also specify the
      // `conflictAlgorithm` to use in case the same dog is inserted twice.
      //
      // In this case, replace any previous data.
      await db.insert(
        'dogs',
        dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    // Create a Dog and add it to the dogs table
    var fido = Dog(
      id: 0,
      name: 'Fido',
      age: 35,
    );

    await insertDog(fido);

    // A method that retrieves all the dogs from the dogs table.
    Future<List<Dog>> dogs() async {
      // Get a reference to the database.
      final db = await database;

      // Query the table for all The Dogs.
      final List<Map<String, dynamic>> maps = await db.query('dogs');

      // Convert the List<Map<String, dynamic> into a List<Dog>.
      return List.generate(maps.length, (i) {
        return Dog(
          id: maps[i]['id'],
          name: maps[i]['name'],
          age: maps[i]['age'],
        );
      });
    }

// Now, use the method above to retrieve all the dogs.
    print(await dogs()); // Prints a list that include Fido.
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CustomColors.charcoal,
        cardColor: CustomColors.independence,
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: CustomColors.chocolateWeb,
              secondary: CustomColors.bigDipOruby,
            ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: CustomColors.bigDipOruby,
          foregroundColor: CustomColors.lightYellow,
        ),
        appBarTheme: const AppBarTheme(
          color: CustomColors.independence,
        ),
      ),
      onGenerateRoute: Application.router.generator,
    );
  }
}
