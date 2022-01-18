import 'dart:typed_data';

class NewImage {
  String title;
  String mimeType;
  Uint8List imageData;

  NewImage({
    required this.title,
    required this.mimeType,
    required this.imageData,
  });

  Map<String, dynamic> toMap() =>
      {"title": title, "data": imageData, "mime_type": mimeType};
}
