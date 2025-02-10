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
  Future<List<FilmsList>> findAllByUserId(String? token, int userId) {
    return _listService.findAllByUserId(token, userId);
  }

  /// Se conecta al servicio para insertar una lista.
  ///
  /// Devuelve el `int` id generado para la lista
  Future<int?> insert(String? token, FilmsList list, int userId) {
    return _listService.insert(token, list, userId);
  }

  /// Se conecta al servicio para actualizar una lista.
  ///
  /// Devuelve un `bool` con el resultado.
  Future<bool> update(String? token, FilmsList list, int userId) {
    return _listService.update(token, list, userId);
  }

  /// Se conecta al servicio para eliminar una lista.
  ///
  /// Devuelve un `bool` con el resultado.
  Future<bool> delete(String? token, int id) {
    return _listService.delete(token, id);
  }

  /// Se conecta al servicio para insertar una película a una lista.
  ///
  /// Devuelve el `int` id generado para la relación.
  Future<ListResult<bool>> addFilmToList(String? token, int listId, int filmId) {
    return _listService.addFilmToList(token, listId, filmId);
  }

  /// Se conecta al servicio para eliminar una película de una lista.
  ///
  /// Devuelve `bool` con el resultado.
  Future<bool> removeFilmFromList(String? token, int listId, int filmId) {
    return _listService.removeFilmFromList(token, listId, filmId);
  }

  /// Se conecta al servicio para calcular las listas que tiene un usuario.
  ///
  /// Devuelve un `int` con el resultado.
  Future<int> countAllListsByUserId(String? token, int userId) {
    return _listService.countAllListsByUserId(token, userId);
  }
}