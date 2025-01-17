import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier {
  // TODO: info usuario

  // Tema
  ThemeMode _themeMode = ThemeMode.light;
  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}