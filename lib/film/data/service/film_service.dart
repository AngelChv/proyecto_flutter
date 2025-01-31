import '../../domain/film.dart';

/// Permite definir servicios para las películas
///
/// Contiene los CRUD necesarios y permite que se pueda utilizar la interfáz
/// y así abstraerse de un uso concreto del servicio.
/// De este modo se obtiene lo deseado independientemente del funcionamiento
/// interno.
abstract class FilmService {
  Future<List<Film>> getAll();
  Future<int?> insert(Film film);
  Future<bool> update(Film film);
  Future<bool> delete(int id);
}