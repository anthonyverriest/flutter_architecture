import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/data/mockdb/mockdb.dart';
import 'package:flutter_architecture/src/data/models/user.dart';
import 'package:flutter_architecture/src/data/repositories/auth.dart';

enum SignUpStates {
  loading,
  defaultError,
  success,
  weakPassword,
  invalidEmailOrAlreadyTaken;
}

class SignUpBloc extends ValueNotifier<SignUpStates?> {
  final AuthRepository _authRepository = AuthRepository();

  SignUpBloc() : super(null);

  void signUp(String email, String password) async {
    value = SignUpStates.loading;

    value = await _signUp(email, password);
  }

  Future<SignUpStates> _signUp(String email, String password) async {
    try {
      final User? user = await _authRepository.signUp(email, password);

      if (user == null) {
        return SignUpStates.defaultError;
      }

      await _authRepository.signOut();

      return SignUpStates.success;
    } on MockDBException catch (e) {
      if (e.toString() == 'weak-password') {
        return SignUpStates.weakPassword;
      } else if (e.toString() == 'email-already-in-use') {
        return SignUpStates.invalidEmailOrAlreadyTaken;
      } else if (e.toString() == 'invalid-email') {
        return SignUpStates.invalidEmailOrAlreadyTaken;
      }
      return SignUpStates.defaultError;
    } catch (_) {
      return SignUpStates.defaultError;
    }
  }
}
