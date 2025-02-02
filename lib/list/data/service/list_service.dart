import 'package:proyecto_flutter/list/domain/list.dart';

/// Permite definir servicios para las listas.
///
/// Contiene los CRUD necesarios y permite que se pueda utilizar la interfáz
/// y así abstraerse de un uso concreto del servicio.
/// De este modo se obtiene lo deseado independientemente del funcionamiento
/// interno.
abstract class ListService {
  Future<List<FilmsList>> getAll();
  Future<int?> insert(FilmsList list);
  Future<bool> update(FilmsList list);
  Future<bool> delete(int id);
}