import 'package:flutter_architecture/src/data/models/book.dart';
import 'package:flutter_architecture/src/data/providers/book.dart';

class BookRepository {
  final _bookProvider = BookProvider();

  BookRepository();

  Stream<List<Book>> getBooks() async* {
    await Future.delayed(const Duration(seconds: 2)); //EXAMPLE

    final stream = await _bookProvider.getBooks();

    yield* stream.map((event) => event.map((e) => Book.fromMap(e)).toList());
  }
}
