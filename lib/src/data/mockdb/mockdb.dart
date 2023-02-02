import 'package:flutter_architecture/src/data/models/user.dart';

class MockDBException implements Exception {
  final String message;

  const MockDBException(this.message);

  @override
  String toString() {
    return message;
  }
}

class MockDB {
  static final MockDB _instance = MockDB._internal();

  factory MockDB() {
    return _instance;
  }

  MockDB._internal();

  late User? _user = const User('Super new user');

  User? get user => _user;

  User? signIn(String email, String password) {
    /*if (_user == null) {
      throw const MockDBException('user-not-found');
    }*/
    if (email != 'admin@gmail.com') {
      throw const MockDBException('invalid-email');
    }
    if (password != 'admin') {
      throw const MockDBException('wrong-password');
    }
    return _user;
  }

  User? signUp(String email, String password) {
    _user = const User('Super new user');

    return _user;
  }

  Stream<List<Map>> getListOfBooks() => Stream.fromIterable([
        const [
          <String, String>{'title': 'one'},
          <String, String>{'title': 'two'}
        ]
      ]);
}
