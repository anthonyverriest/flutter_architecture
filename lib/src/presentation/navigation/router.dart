import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/presentation/navigation/auth.dart';
import 'package:flutter_architecture/src/presentation/pages/error.dart';
import 'package:flutter_architecture/src/presentation/wrappers/auth.dart';

class AppRouter {
  static final authSPANavigator = AuthSPANavigator();

  static final routes = <String, Widget Function(BuildContext)>{
    '/': (_) => AuthWrapper(),
  };

  static Route onGenerateRoute(RouteSettings routeSettings) =>
      MaterialPageRoute(builder: (context) => const ErrorPage());
}
