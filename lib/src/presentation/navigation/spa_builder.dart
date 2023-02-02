import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/presentation/navigation/spa_navigator.dart';

class SPABuilder extends StatelessWidget {
  final SPANavigator spaNavigator;

  const SPABuilder({Key? key, required this.spaNavigator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: spaNavigator.notifier,
      builder: (context, value, _) {
        return spaNavigator.route;
      },
    );
  }
}
