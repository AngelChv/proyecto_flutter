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

  Future<bool> createFilm(Film film) async {
    final int? id = await filmRepository.insert(film);
    // todo realizar comprobaciones
    bool isSuccess = false;
    if (id != null) {
      film.id = id;
      _films.add(film);
      isSuccess = true;
    }
    notifyListeners();
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
}
