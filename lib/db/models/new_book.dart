import 'package:library_app/db/models/new_image.dart';

class NewBook {
  final String title;
  final int pages;
  final NewImage? image;

  const NewBook({
    required this.title,
    required this.pages,
    this.image,
  });
}
