import 'package:flutter/material.dart';
import 'package:library_app/models/book.dart';

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
      title: 'Library',
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
      home: const MyHomePage(title: 'All books'),
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
      // body:
      // Padding(
      //   padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      //   child: ListView.builder(
      //     itemBuilder: (context, index) => BookCard(
      //         title: dummyBooks[index]['title'] as String,
      //         authors: dummyBooks[index]['author'] as List<String>),
      //   ),
      // ),
    );
  }
}

class BookCard extends StatelessWidget {
  final Book data;

  const BookCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String authorsString =
        data.authors.length > 1 ? data.authors.join(', ') : data.authors[0];

    return Container(
      constraints: const BoxConstraints(maxHeight: 450),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 12.0),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(data.imageUrl),
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                data.title,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize,
                    color: CustomColors.lightYellow),
              ),
              const SizedBox(height: 8.0),
              Text(
                authorsString,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle1?.fontSize,
                  color: CustomColors.lightYellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
