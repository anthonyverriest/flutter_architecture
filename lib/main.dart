import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/presentation/extensions/build_context.dart';
import 'package:flutter_architecture/src/presentation/navigation/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main()  {
  //await myErrorsHandler.initialize();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    //myErrorsHandler.onErrorDetails(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    //myErrorsHandler.onError(error, stack);
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: AppRouter.routes,
      onGenerateRoute: AppRouter.onGenerateRoute,
      onGenerateTitle: (context) => context.intl.title,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
