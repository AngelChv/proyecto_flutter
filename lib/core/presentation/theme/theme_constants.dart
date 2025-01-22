import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  snackBarTheme: SnackBarThemeData(
    width: 300,
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  snackBarTheme: SnackBarThemeData(
    width: 300,
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
  ),
);
