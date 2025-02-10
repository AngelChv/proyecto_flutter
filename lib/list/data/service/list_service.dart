import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';

/// Permite definir servicios para las listas.
///
/// Contiene los CRUD necesarios y permite que se pueda utilizar la interfáz
/// y así abstraerse de un uso concreto del servicio.
/// De este modo se obtiene lo deseado independientemente del funcionamiento
/// interno.
abstract class ListService {
  Future<List<FilmsList>> findAllByUserId(String? token, int userId);
  Future<int?> insert(String? token, FilmsList list, int userId);
  Future<bool> update(String? token, FilmsList list, int userId);
  Future<bool> delete(String? token, int id);
  Future<ListResult<bool>> addFilmToList(String? token, int listId, int filmId);
  Future<bool> removeFilmFromList(String? token, int listId, int filmId);
  Future<int> countAllListsByUserId(String? token, int userId);
}