import 'package:proyecto_flutter/data/service/film_sqlite_service.dart';

import '../../domain/models/film.dart';
import '../model/film_service.dart';

class FilmRepository {
  // De momento solo uso el service de sqlite
  // Pero en esta clase pienso gestionar el acceso a las películas
  // de diferentes fuentes com sqlite y un api.
  final FilmService filmService = FilmSqliteService();

  Future<List<Film>> getAll() {
    return filmService.getAll();
  }

  Future<int?> insert(Film film) {
    return filmService.insert(film);
  }
}