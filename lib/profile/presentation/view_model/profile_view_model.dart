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

  // Idioma
  static const Map<String, String> _languages = {
    "ES": "Español",
    "EN": "Inglés",
    "GE": "Alemán",
    "IT": "Italiano",
    "PO": "Portugués",
  };

  get languages => _languages;

  List<DropdownMenuEntry<String>> languagesAsDropDownMenuEntries() {
    return _languages.entries.map((entry) {
      return DropdownMenuEntry<String>(
        value: entry.key,
        label: entry.value,
      );
    }).toList();
  }

  String _language = _languages.keys.first;
  get language => _language;

  changeLanguage(String key) {
    _language = _languages.containsKey(key) ? key : _language;
  }
}