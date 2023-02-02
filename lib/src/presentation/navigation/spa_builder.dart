import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/presentation/navigation/spa_navigator.dart';

class SPABuilder<T extends SPANavigator> extends InheritedWidget {
  final T spaNavigator;

  SPABuilder({required this.spaNavigator, super.key})
      : super(child: _SPABuilder(spaNavigator: spaNavigator));

  @override
  bool updateShouldNotify(covariant SPABuilder oldWidget) => false;
}

class _SPABuilder<T extends SPANavigator> extends StatelessWidget {
  final T spaNavigator;

  const _SPABuilder({Key? key, required this.spaNavigator}) : super(key: key);

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
