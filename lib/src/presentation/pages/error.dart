import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/presentation/extensions/build_context.dart';

class ErrorPage extends StatelessWidget {
  final String? message;

  static const routeName = '/error';

  const ErrorPage({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            message ?? context.intl.somethingWentWrong,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
