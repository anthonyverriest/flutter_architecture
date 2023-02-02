import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/presentation/navigation/spa_builder.dart';
import 'package:flutter_architecture/src/presentation/navigation/spa_navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextModifier on BuildContext {
  AppLocalizations get intl => AppLocalizations.of(this);

  ThemeData get theme => Theme.of(this);

  MediaQueryData get media => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);

  ModalRoute get route => ModalRoute.of(this)!;

  T spaNavigator<T extends SPANavigator>() {
    return dependOnInheritedWidgetOfExactType<SPABuilder<T>>()!.spaNavigator;
  }
}
