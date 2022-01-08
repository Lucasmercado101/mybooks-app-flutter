import 'package:fluro/fluro.dart';
import 'package:flutter/widgets.dart';
import 'package:library_app/pages/home.dart';
import 'package:library_app/pages/new_book.dart';

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const MyHomePage();
});

var newBookHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return const NewBookPage();
});
