import 'package:flutter/material.dart';
import 'package:proyecto_flutter/film/data/repository/film_repository.dart';
import 'package:proyecto_flutter/list/data/repository/list_repository.dart';
import 'package:proyecto_flutter/profile/domain/profile_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Gestiona el estado del perfíl y la configuración.
///
/// Gestiona el estado y permanencia de:
/// * El tema.
/// * Idioma.
/// * Estadísticas.
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

  String _language = _languages.keys.first;
  get language => _language;

  changeLanguage(String key) {
    _language = _languages.containsKey(key) ? key : _language;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("language", _language);
    });
    notifyListeners();
  }

  // Estadísticas:
  Future<ProfileStats> getStats(int userId) async {
    final totalFilms = await FilmRepository().countAllFilms();
    final totalLists = await ListRepository().countAllListsByUserId(userId);
    return ProfileStats(totalFilms: totalFilms, totalLists: totalLists);
  }
}