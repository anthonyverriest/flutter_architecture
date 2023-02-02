import 'package:flutter/material.dart';

abstract class SPANavigator {
  final Map<String, Widget Function()> _routes;

  late Widget route;
  late ValueNotifier<String> notifier;

  SPANavigator(this._routes, String initialRouteName) {
    route = _routes[initialRouteName]!();

    notifier = ValueNotifier<String>(initialRouteName);
  }

  void goTo(String routeName) {
    assert(_routes.containsKey(routeName));

    route = _routes[routeName]!();

    notifier.value = routeName;
  }
}
