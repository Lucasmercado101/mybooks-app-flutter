class Book {
  final int id;
  final String title;
  final int pages;

  const Book({
    required this.title,
    required this.pages,
    required this.id,
  });

  Book.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        pages = map['pages'],
        id = map['id'];

  toMap() {
    return {
      'title': title,
      'pages': pages,
      'id': id,
    };
  }
}
