import 'package:flutter_architecture/src/data/mockdb/mockdb.dart';

class BookProvider {
  Future<Stream<List<Map>>> getBooks() async {
    return MockDB().getListOfBooks();
  }
}
