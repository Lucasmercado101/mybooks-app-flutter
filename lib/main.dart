import 'package:flutter/material.dart';

class CustomColors {
  static const Color charcoal = Color(0xFF30404F);
  static const Color independence = Color(0xFF3E4C65);
  static const Color lightYellow = Color(0xFFF2F5D5);
  static const Color chocolateWeb = Color(0xFFD16821);
  static const Color bigDipOruby = Color(0xFFA62646);
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CustomColors.charcoal,
        cardColor: CustomColors.independence,
        colorScheme: ThemeData.dark().colorScheme.copyWith(
              primary: CustomColors.chocolateWeb,
              secondary: CustomColors.bigDipOruby,
            ),
        appBarTheme: const AppBarTheme(
          color: CustomColors.independence,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BookCard(
          title: 'The Psychology of Money', authors: const ['Morgan Housel']),
    );
  }
}

class BookCard extends StatelessWidget {
  String title;
  List<String> authors;

  BookCard({Key? key, required this.title, required this.authors})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                  "https://covers.openlibrary.org/b/isbn/9780857197689-L.jpg"),
            ),
            Text(title),
            Text(authors.length > 1 ? authors.join(', ') : authors[0]),
          ],
        ),
      ),
    );
  }
}

// 30404f,3e4c65,f2f5d5,d16821,a62646


