import 'package:proyecto_flutter/list/data/service/list_service.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';
import 'package:proyecto_flutter/list/domain/list_sqlite_result.dart';

/// De momento no esta implementado
class ListApiService implements ListService {
  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    return await true;
  }

  @override
  Future<List<FilmsList>> findAllByUserId(int userId) async {
    // TODO: implement getAll
    return await [];
  }

  @override
  Future<int?> insert(FilmsList list, int userId) async {
    // TODO: implement insert
    return await 0;
  }

  @override
  Future<bool> update(FilmsList list, intUserId) async {
    // TODO: implement update
    return await false;
  }

  @override
  Future<ListResult<bool>> addFilmToList(int listId, int filmId) async {
    return await ListSqliteResult<bool>(true, null);
  }

  @override
  Future<bool> removeFilmFromList(int listId, int filmId) async {
    return await true;
  }

  @override
  Future<int> countAllListsByUserId(int userId) async {
    return await 10;
  }


}