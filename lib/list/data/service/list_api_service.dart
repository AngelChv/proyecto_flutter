import 'dart:convert';
import 'dart:developer';

import 'package:proyecto_flutter/core/domain/http_status_exception.dart';
import 'package:proyecto_flutter/list/data/service/list_service.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_api_result.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';

import 'package:http/http.dart' as http;

/// De momento no esta implementado
class ListApiService implements ListService {
  static const String urlBase = "http://127.0.0.1:8000/lists";

  @override
  Future<bool> delete(String? token, int id) async {
    final url = Uri.parse("$urlBase/$id");
    try {
      final response = await http.delete(
        headers: {
          "Authorization": "Bearer $token",
        },
        url,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      }
    } catch (e, stackTrace) {
      log("Excepción al eliminar una lista: $e", stackTrace: stackTrace);
    }
    return false;
  }

  @override
  Future<List<FilmsList>> findAllByUserId(String? token, int userId) async {
    final url = Uri.parse("$urlBase/$userId");
    try {
      final response = await http.get(
        headers: {
          "Authorization": "Bearer $token",
        },
        url,
      );
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
  Future<int?> insert(String? token, FilmsList list, int userId) async {
    final url = Uri.parse("$urlBase/create");
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
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
  Future<bool> update(String? token, FilmsList list, int userId) async {
    final url = Uri.parse("$urlBase/update");
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
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
  Future<ListResult<bool>> addFilmToList(
    String? token,
    int listId,
    int filmId,
  ) async {
    final url = Uri.parse("$urlBase/add_film/$listId/$filmId");
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return ListApiResult(jsonDecode(response.body) as bool, null);
      } else {
        return ListApiResult(false, HttpStatusException(response.statusCode));
      }
    } catch (e, stackTrace) {
      log("Excepción al añadir una película a la lista: $e", stackTrace: stackTrace);
    }
    return ListApiResult<bool>(false, null);
  }

  @override
  Future<bool> removeFilmFromList(String? token, int listId, int filmId) async {
    final url = Uri.parse("$urlBase/remove_film/$listId/$filmId");
    try {
      final response = await http.delete(
        headers: {
          "Authorization": "Bearer $token",
        },
        url,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      }
    } catch (e, stackTrace) {
      log("Excepción al eliminar una película de la lista: $e", stackTrace: stackTrace);
    }
    return false;
  }

  @override
  Future<int> countAllListsByUserId(String? token, int userId) async {
    final url = Uri.parse("$urlBase/count_all_of_user/$userId");
    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as int;
      }
    } catch (e, stackTrace) {
      log("Excepción al crear una lista: $e", stackTrace: stackTrace);
    }
    return 0;
  }
}
