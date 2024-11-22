import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color.fromRGBO(32, 207, 165, 1),
    surface: Color.fromRGBO(215, 216, 219, 1),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    primary: Color.fromRGBO(32, 207, 165, 1),
    surface: Color.fromRGBO(42, 44, 48, 1),
  ),
);
