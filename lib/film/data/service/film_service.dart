import '../../domain/film.dart';

abstract class FilmService {
  Future<List<Film>> getAll();
  Future<int?> insert(Film film);
  Future<bool> update(Film film);
  Future<bool> delete(int id);
}