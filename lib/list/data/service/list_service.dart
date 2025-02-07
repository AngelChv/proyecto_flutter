import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';

/// Permite definir servicios para las listas.
///
/// Contiene los CRUD necesarios y permite que se pueda utilizar la interfáz
/// y así abstraerse de un uso concreto del servicio.
/// De este modo se obtiene lo deseado independientemente del funcionamiento
/// interno.
abstract class ListService {
  Future<List<FilmsList>> findAllByUserId(int userId);
  Future<int?> insert(FilmsList list, int userId);
  Future<bool> update(FilmsList list, int userId);
  Future<bool> delete(int id);
  Future<ListResult<bool>> addFilmToList(int listId, int filmId);
  Future<bool> removeFilmFromList(int listId, int filmId);
}