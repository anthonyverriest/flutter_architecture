import 'package:flutter/material.dart';

abstract class SPANavigator {
  final Map<String, Widget Function()> routes;

  late Widget route;
  late ValueNotifier<String> notifier;

  SPANavigator(this.routes, String initialRouteName) {
    route = routes[initialRouteName]!();

    notifier = ValueNotifier<String>(initialRouteName);
  }

  void goTo(String routeName) {
    assert(routes.containsKey(routeName));

    route = routes[routeName]!();

    notifier.value = routeName;
  }
}
