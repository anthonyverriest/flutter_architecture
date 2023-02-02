import 'package:flutter_architecture/src/data/mockdb/mockdb.dart';
import 'package:flutter_architecture/src/data/models/user.dart';

class AuthRepository {
  Future<User?> signIn(String email, String password) async =>
      MockDB().signIn(email, password);

  Future<User?> signUp(String email, String password) async =>
      MockDB().signUp(email, password);

  Future<void> signOut() async {}

  Future<bool> hasUser() async => MockDB().user != null;

  Future<User?> getUser() async => MockDB().user;
}
