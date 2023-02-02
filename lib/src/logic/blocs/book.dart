import 'dart:async';

import 'package:flutter_architecture/src/data/models/book.dart';
import 'package:flutter_architecture/src/data/repositories/book.dart';

class BookBloc {
  final _bookRepository = BookRepository();

  Stream<List<Book>> getBooks() => _bookRepository.getBooks();
}
