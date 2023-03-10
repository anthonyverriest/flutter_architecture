import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/logic/blocs/auth.dart';
import 'package:flutter_architecture/src/presentation/navigation/auth.dart';
import 'package:flutter_architecture/src/presentation/navigation/spa_builder.dart';
import 'package:flutter_architecture/src/presentation/pages/book.dart';

class AuthWrapper extends StatelessWidget {
  final _authBloc = AuthBloc();

  AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: _authBloc,
        builder: (context, value, child) {
          if (value == AuthStates.loading) {
            return const CircularProgressIndicator();
          }
          if (value == AuthStates.authenticated) {
            return BookPage();
          }
          return SPABuilder(spaNavigator: AuthSPANavigator());
        },
      ),
    );
  }
}
