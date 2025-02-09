import 'dart:convert';
import 'dart:developer';

import 'package:proyecto_flutter/list/data/service/list_service.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';
import 'package:proyecto_flutter/list/domain/list_sqlite_result.dart';

import 'package:http/http.dart' as http;

/// De momento no esta implementado
class ListApiService implements ListService {
  static const String urlBase = "http://127.0.0.1:8000/lists";

  @override
  Future<bool> delete(int id) async {
    final url = Uri.parse("$urlBase/$id");
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      }
    } catch (e, stackTrace) {
      log("Excepción al eliminar una lista: $e", stackTrace: stackTrace);
    }
    return false;
  }

  @override
  Future<List<FilmsList>> findAllByUserId(int userId) async {
    final url = Uri.parse("$urlBase/$userId");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        return data.map((map) {
          return FilmsList.fromMap(map as Map<String, dynamic>);
        }).toList();
      }
    } catch (e, stackTrace) {
      log("Excepción al obtener las películas: $e", stackTrace: stackTrace);
    }
    return [];
  }

  @override
  Future<int?> insert(FilmsList list, int userId) async {
    final url = Uri.parse("$urlBase/create");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(list.toMapWithoutId(userId)),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as int;
      }
    } catch (e, stackTrace) {
      log("Excepción al crear una lista: $e", stackTrace: stackTrace);
    }
    return null;
  }

  @override
  Future<bool> update(FilmsList list, int userId) async {
    final url = Uri.parse("$urlBase/update");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(list.toMapWithId(userId)),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      }
    } catch (e, stackTrace) {
      log("Excepción al crear una lista: $e", stackTrace: stackTrace);
    }
    return false;
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