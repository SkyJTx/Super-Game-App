import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightBlue,
    primary: Colors.lightBlue,
    surface: Colors.white,
  ),
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: lightTheme.colorScheme.secondary,
    primary: lightTheme.colorScheme.secondary,
    secondary: lightTheme.colorScheme.primary,
    surface: Colors.grey[850]
  ),
  brightness: Brightness.dark,
);
