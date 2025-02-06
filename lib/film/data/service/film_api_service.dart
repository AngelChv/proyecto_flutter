import 'package:proyecto_flutter/film/data/service/film_service.dart';
import 'package:proyecto_flutter/film/domain/film.dart';

/// De momento no esta implementado
class FilmApiService implements FilmService {
  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    return await true;
  }

  @override
  Future<List<Film>> getAll() async {
    // TODO: implement getAll
    return await [];
  }

  @override
  Future<int?> insert(Film film) async {
    // TODO: implement insert
    return await 0;
  }

  @override
  Future<bool> update(Film film) async {
    // TODO: implement update
    return await false;
  }

  @override
  Future<List<Film>> getFilmsByListId(int id) async {
    return await [];
  }
}