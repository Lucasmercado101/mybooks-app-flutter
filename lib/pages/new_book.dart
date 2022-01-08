import "package:flutter/material.dart";

class NewBook extends StatefulWidget {
  @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Book"),
      ),
      body: Center(
        child: Text("New Book"),
      ),
    );
  }
}
