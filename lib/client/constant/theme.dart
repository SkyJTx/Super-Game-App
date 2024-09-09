import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.lightBlue,
    primary: Colors.lightBlue,
    surface: Colors.white,
    brightness: Brightness.light,
  ),
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.yellow[700]!,
    primary: Colors.yellow[700]!,
    surface: Colors.grey[850],
    brightness: Brightness.dark,
  ),
  brightness: Brightness.dark,
);
