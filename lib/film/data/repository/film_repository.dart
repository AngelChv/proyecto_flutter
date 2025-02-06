import 'package:flutter/foundation.dart';
import 'package:proyecto_flutter/film/data/service/film_api_service.dart';
import 'package:proyecto_flutter/film/data/service/film_sqlite_service.dart';

import '../../domain/film.dart';
import '../service/film_service.dart';

/// Intermediario entre los servicios y el ViewModel.
///
/// Se comunica con los diferentes servicios de las películas.
/// * [FilmSqliteService]
/// * [FilmApiService]
///
/// Estos servicios deben de implementar la clase: [FilmService]
///
/// Actualmente esta configurado para que en web se conecte a la api
/// y en el resto de sistemas a la base de datos SQLite.
class FilmRepository {
  late final FilmService _filmService;

  FilmRepository(){
    if (kIsWeb) {
      _filmService = FilmApiService();
    } else {
      _filmService = FilmSqliteService();
    }
  }

  /// Se conecta al servicio para obtener todas las películas.
  Future<List<Film>> getAll() {
    return _filmService.getAll();
  }

  /// Se conecta al servicio para insertar una película.
  ///
  /// Devuelve el `int` id generado para la película
  Future<int?> insert(Film film) {
    return _filmService.insert(film);
  }

  /// Se conecta al servicio para actualizar una película.
  ///
  /// Devuelve un `bool` con el resultado.
  Future<bool> update(Film film) {
    return _filmService.update(film);
  }

  /// Se conecta al servicio para eliminar una película.
  ///
  /// Devuelve un `bool` con el resultado.
  Future<bool> delete(int id) {
    return _filmService.delete(id);
  }

  Future<List<Film>> getFilmsByListId(int id) {
    return _filmService.getFilmsByListId(id);
  }
}