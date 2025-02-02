import 'package:proyecto_flutter/list/data/service/list_service.dart';
import 'package:proyecto_flutter/list/domain/list.dart';

/// De momento no esta implementado
class ListApiService implements ListService {
  @override
  Future<bool> delete(int id) async {
    // TODO: implement delete
    return await true;
  }

  @override
  Future<List<FilmsList>> getAll() async {
    // TODO: implement getAll
    return await [];
  }

  @override
  Future<int?> insert(FilmsList list) async {
    // TODO: implement insert
    return await 0;
  }

  @override
  Future<bool> update(FilmsList list) async {
    // TODO: implement update
    return await false;
  }
}