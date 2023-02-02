import 'package:flutter/foundation.dart';
import 'package:flutter_architecture/src/logic/blocs/sign_in.dart';
import 'package:flutter_architecture/src/logic/value_messenger.dart';

enum AuthStates {
  authenticated,
  unauthenticated;
}

class AuthBloc extends ValueNotifier<AuthStates> {
  final messenger = ValueMessenger();

  AuthBloc() : super(AuthStates.unauthenticated) {
    setSignInBlocListener();
  }

  void setSignInBlocListener() {
    messenger.register<SignInBloc, SignInStates>((message) {
      if (message == SignInStates.success) {
        value = AuthStates.authenticated;
      }
    });
  }
}
