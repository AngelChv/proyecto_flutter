import 'dart:convert';
import 'dart:developer';

import 'package:proyecto_flutter/film/data/service/film_service.dart';
import 'package:proyecto_flutter/film/domain/film.dart';
import 'package:http/http.dart' as http;

/// De momento no esta implementado
class FilmApiService implements FilmService {
  static const String urlBase = "http://127.0.0.1:8000/films";

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
      log("Excepción al eliminar una película: $e", stackTrace: stackTrace);
    }
    return false;
  }

  @override
  Future<List<Film>> getAll(String? token) async {
    final url = Uri.parse("$urlBase/");
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
          return Film.fromMap(map as Map<String, dynamic>);
        }).toList();
      }
    } catch (e, stackTrace) {
      log("Excepción al obtener las películas: $e", stackTrace: stackTrace);
    }
    return [];
  }

  @override
  Future<int?> insert(String? token, Film film) async {
    final url = Uri.parse("$urlBase/create");
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(film.toMapWithOutId()),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as int;
      }
    } catch (e, stackTrace) {
      log("Excepción al crear una película: $e", stackTrace: stackTrace);
    }
    return null;
  }

  @override
  Future<bool> update(String? token, Film film) async {
    final url = Uri.parse("$urlBase/update");
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode(film.toMapWithId()),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      }
    } catch (e, stackTrace) {
      log("Excepción al crear una película: $e", stackTrace: stackTrace);
    }
    return false;
  }

  @override
  Future<List<Film>> getFilmsByListId(String? token, int id) async {
    final url = Uri.parse("$urlBase/of_list/$id");
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
          return Film.fromMap(map as Map<String, dynamic>);
        }).toList();
      }
    } catch (e, stackTrace) {
      log("Excepción al obtener las películas de la lista: $e", stackTrace: stackTrace);
    }
    return [];
  }

  @override
  Future<Film?> findById(String? token, int id) async {
    final url = Uri.parse("$urlBase/$id");
    try {
      final response = await http.get(
        headers: {
          "Authorization": "Bearer $token",
        },
        url,
      );
      if (response.statusCode == 200) {
        return Film.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      }
    } catch (e, stackTrace) {
      log("Excepción al obtener las películas: $e", stackTrace: stackTrace);
    }
    return null;
  }

  @override
  Future<int> countAllFilms(String? token) async {
    final url = Uri.parse("$urlBase/countAll");
    try {
      final response = await http.get(
        headers: {
          "Authorization": "Bearer $token",
        },
        url,
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as int;
      }
    } catch (e, stackTrace) {
      log("Excepción al eliminar una película: $e", stackTrace: stackTrace);
    }
    return 0;
  }
}
