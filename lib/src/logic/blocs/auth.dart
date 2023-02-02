import 'package:flutter/foundation.dart';
import 'package:flutter_architecture/src/data/repositories/auth.dart';
import 'package:flutter_architecture/src/logic/blocs/sign_in.dart';
import 'package:flutter_architecture/src/logic/value_messenger.dart';

enum AuthStates {
  loading,
  authenticated,
  unauthenticated;
}

class AuthBloc extends ValueNotifier<AuthStates> {
  final _messenger = ValueMessenger();
  final _authRepository = AuthRepository();

  AuthBloc() : super(AuthStates.unauthenticated) {
    _messenger.register<SignInBloc, SignInStates>(_signInCallback);

    //tryAuthenticate();
  }

  void _signInCallback(message) {
    if (message == SignInStates.success) {
      tryAuthenticate();
    }
  }

  void tryAuthenticate() async {
    if (await _authRepository.hasUser()) {
      _messenger.unregister<SignInBloc, SignInStates>(_signInCallback);
      value = AuthStates.authenticated;
    } else {
      value = AuthStates.unauthenticated;
    }
  }
}
