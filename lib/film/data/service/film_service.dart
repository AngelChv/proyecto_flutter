import '../../domain/film.dart';

/// Permite definir servicios para las películas
///
/// Contiene los CRUD necesarios y permite que se pueda utilizar la interfáz
/// y así abstraerse de un uso concreto del servicio.
/// De este modo se obtiene lo deseado independientemente del funcionamiento
/// interno.
abstract class FilmService {
  Future<List<Film>> getAll(String? token);
  Future<Film?> findById(String? token, int id);
  Future<int?> insert(String? token, Film film);
  Future<bool> update(String? token, Film film);
  Future<bool> delete(String? token, int id);
  Future<List<Film>> getFilmsByListId(String? token, int id);
  Future<int> countAllFilms(String? token);
}