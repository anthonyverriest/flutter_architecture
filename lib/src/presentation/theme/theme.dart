import 'package:flutter/material.dart';

class AppTheme {
  static const double kBorderRadius = 4.0;
  static const double kPaddingLarge = 20.0;
  static const double kPaddingMedium = 14.0;
  static const double kPaddingSmall = 10.0;

  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.purple,
      secondary: Colors.blue,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.red,
      background: Colors.white,
      surface: Color.fromRGBO(240, 240, 240, 1.0),
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    useMaterial3: true,
    cardTheme: CardTheme(
      color: Colors.grey[200],
      surfaceTintColor: Colors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        side: const BorderSide(
          color: Colors.lightBlue,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBorderRadius)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.blue,
    useMaterial3: true,
  );
}
