class NewBook {
  final String title;
  final int pages;

  const NewBook({
    required this.title,
    required this.pages,
  });

  toMap() {
    return {
      'title': title,
      'pages': pages,
    };
  }
}
