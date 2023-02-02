import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/presentation/navigation/spa_navigator.dart';
import 'package:flutter_architecture/src/presentation/pages/sign_in.dart';
import 'package:flutter_architecture/src/presentation/pages/sign_up.dart';

class AuthSPANavigator extends SPANavigator {
  static final Map<String, Widget Function()> routes = {
    SignInPage.routeName: () => const SignInPage(),
    SignUpPage.routeName: () => const SignUpPage(),
  };

  AuthSPANavigator() : super(routes, SignInPage.routeName);
}
