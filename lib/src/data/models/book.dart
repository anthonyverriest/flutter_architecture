class Book {
  final String title;

  const Book({required this.title});

  static Book fromMap(Map<dynamic, dynamic> data) {
    return Book(title: data['title']);
  }
}
