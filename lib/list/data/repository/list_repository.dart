import 'package:proyecto_flutter/list/data/service/list_api_service.dart';
import 'package:proyecto_flutter/list/data/service/list_service.dart';
import 'package:flutter/foundation.dart';
import 'package:proyecto_flutter/list/data/service/list_sqlite_service.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';

class ListRepository {
  late final ListService _listService;

  ListRepository() {
    if (kIsWeb) {
      _listService = ListApiService();
    } else {
      _listService = ListSqliteService();
    }
  }

  /// Se conecta al servicio para obtener todas las listas.
  Future<List<FilmsList>> findAllByUserId(int userId) {
    return _listService.findAllByUserId(userId);
  }

  /// Se conecta al servicio para insertar una lista.
  ///
  /// Devuelve el `int` id generado para la lista
  Future<int?> insert(FilmsList list, int userId) {
    return _listService.insert(list, userId);
  }

  /// Se conecta al servicio para actualizar una lista.
  ///
  /// Devuelve un `bool` con el resultado.
  Future<bool> update(FilmsList list, int userId) {
    return _listService.update(list, userId);
  }

  /// Se conecta al servicio para eliminar una lista.
  ///
  /// Devuelve un `bool` con el resultado.
  Future<bool> delete(int id) {
    return _listService.delete(id);
  }

  /// Se conecta al servicio para insertar una película a una lista.
  ///
  /// Devuelve el `int` id generado para la relación.
  Future<ListResult<bool>> addFilmToList(int listId, int filmId) {
    return _listService.addFilmToList(listId, filmId);
  }

  Future<bool> removeFilmFromList(int listId, int filmId) {
    return _listService.removeFilmFromList(listId, filmId);
  }
}