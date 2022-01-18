import 'dart:typed_data';

class Image {
  int id;
  String title;
  String mimeType;
  Uint8List imageData;

  Image(
      {required this.id,
      required this.title,
      required this.mimeType,
      required this.imageData});

  Image.fromMap(Map map)
      : id = map["id"],
        title = map["title"],
        mimeType = map["mime_type"],
        imageData = map["data"];
}
