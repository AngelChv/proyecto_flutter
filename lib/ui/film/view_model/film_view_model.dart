import 'package:flutter/material.dart';
import 'package:proyecto_flutter/data/repository/film_repository.dart';
import 'package:proyecto_flutter/domain/models/film.dart';

class FilmViewModel extends ChangeNotifier {
  final FilmRepository filmRepository = FilmRepository();

  List<Film> _films = [];
  List<Film> get films => List.unmodifiable(_films);

  FilmViewModel() {
    filmRepository.getAll().then((result) {
      _films = result;
      notifyListeners();
    });
  }
}
