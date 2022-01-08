import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './routes_handlers.dart';

class Routes {
  static String root = "/";
  static String newBook = "/new-book";

  static void configureRoutes(FluroRouter router) {
    // TODO:
    // router.notFoundHandler = Handler(
    //     handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
    //   print("ROUTE WAS NOT FOUND !!!");
    //   return;
    // });
    router.define(root, handler: rootHandler);
    router.define(newBook, handler: newBookHandler);
  }
}
