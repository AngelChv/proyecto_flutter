import 'dart:io';

import 'package:flutter/material.dart';
import 'package:proyecto_flutter/film/data/repository/film_repository.dart';
import 'package:proyecto_flutter/film/domain/film.dart';

class FilmViewModel extends ChangeNotifier {
  final FilmRepository filmRepository = FilmRepository();

  List<Film> _films = [];
  List<Film> get films => List.unmodifiable(_films);

  Film? _selectedFilm;
  Film? get selectedFilm => _selectedFilm;
  selectFilm(Film filmToSelect) {
    _selectedFilm = filmToSelect;
    notifyListeners();
  }

  FilmViewModel() {
    filmRepository.getAll().then((result) {
      _films = result;
      notifyListeners();
    });
  }

  Future<bool> createFilm(Film newFilm) async {
    final int? id = await filmRepository.insert(newFilm);
    // todo realizar comprobaciones
    bool isSuccess = false;
    if (id != null) {
      newFilm.id = id;
      _films.add(newFilm);
      isSuccess = true;
    }
    notifyListeners();
    return isSuccess;
  }

  Future<bool> editFilm(Film newFilm) async {
    bool isSuccess = false;
    if (selectedFilm != null) {
      newFilm.id = selectedFilm?.id;
      isSuccess = await filmRepository.update(newFilm);
      if (isSuccess) {
        final int filmIndex = _films.indexOf(_selectedFilm!);
        if (filmIndex >= 0) {
          _films[_films.indexOf(_selectedFilm!)] = newFilm;
          _selectedFilm = newFilm;
          notifyListeners();
        } else {
          isSuccess = false;
        }
      }
    }
    return isSuccess;
  }

  Future<bool> deleteFilm(Film film) async {
    if (await filmRepository.delete(film.id!)) {
      _films.remove(film);
      notifyListeners();
      return true;
    }
    return false;
  }

  // Poster
  // Todo: no se si es mejor guardar el path directamente en un string
  File? _selectedPoster;
  File? get selectedPoster => _selectedPoster;

  void selectPoster(File? image) {
    _selectedPoster = image;

    // Evita que se llame a notifyListeners() antes de que se termine de
    // construir el widget del formulario, programando la función para el
    // siguiente ciclo.
    // Todo: no me parece del todo consistente, habría que ver si se puede hacer de otra manera.
    Future.delayed(Duration.zero, () {
      notifyListeners();
    });
  }
}
