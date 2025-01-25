import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel() {
    SharedPreferences.getInstance().then((prefs) {
      final bool? isDarkMode = prefs.getBool("isDarkMode");
      if (isDarkMode != null) {
        toggleTheme(isDarkMode);
      }

      final String? language = prefs.getString("language");
      if (language != null) {
        changeLanguage(language);
      }
    });
  }

  // TODO: info usuario

  // Tema
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("isDarkMode", _themeMode == ThemeMode.dark);
    });
    notifyListeners();
  }

  // Idioma
  // TODO: usar localizaciones
  static const Map<String, String> _languages = {
    "": "Predeterminado del sistema",
    "es": "Spanish",
    "en": "English",
    "de": "German",
    "it": "Italian",
    "pt": "Portuguese",
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

  // TODO: usar sharedPreferences
  String _language = _languages.keys.first;
  get language => _language;

  changeLanguage(String key) {
    _language = _languages.containsKey(key) ? key : _language;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("language", _language);
    });
    notifyListeners();
  }
}