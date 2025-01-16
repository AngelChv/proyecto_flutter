import 'package:flutter/material.dart';

class FilmViewModel extends ChangeNotifier {
  // Código provisional.
  final List<String> _films = [];
  List<String> get films => List.unmodifiable(_films);

  void addFilm(String film) {
    _films.add(film);
    notifyListeners();
  }

  void removeFilm(String film) {
    _films.remove(film);
    notifyListeners();
  }
}

