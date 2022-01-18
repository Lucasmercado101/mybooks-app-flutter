import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

void main() async {
  runApp(const ProviderScope(child: MyApp()));
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
