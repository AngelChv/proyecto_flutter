import 'dart:convert';
import 'dart:developer';

import 'package:proyecto_flutter/film/data/service/film_service.dart';
import 'package:proyecto_flutter/film/domain/film.dart';
import 'package:http/http.dart' as http;

/// De momento no esta implementado
class FilmApiService implements FilmService {
  static const String urlBase = "http://127.0.0.1:8000/films";

  @override
  Future<bool> delete(int id) async {
    final url = Uri.parse("$urlBase/$id");
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      }
    } catch (e, stackTrace) {
      log("Excepción al eliminar una película: $e", stackTrace: stackTrace);
    }
    return false;
  }

  @override
  Future<List<Film>> getAll() async {
    final url = Uri.parse("$urlBase/");
    try {
      final response = await http.get(url);
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
  Future<int?> insert(Film film) async {
    final url = Uri.parse("$urlBase/create");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
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
  Future<bool> update(Film film) async {
    final url = Uri.parse("$urlBase/update");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
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
  Future<List<Film>> getFilmsByListId(int id) async {
    // todo
    return await [];
  }

  @override
  Future<Film?> findById(int id) async {
    final url = Uri.parse("$urlBase/$id");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // todo no se si funciona sin jsonDecode ?
        return Film.fromMap(response.body as Map<String, dynamic>);
      }
    } catch (e, stackTrace) {
      log("Excepción al obtener las películas: $e", stackTrace: stackTrace);
    }
    return null;
  }

  @override
  Future<int> countAllFilms() async {
    final url = Uri.parse("$urlBase/countAll");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as int;
      }
    } catch (e, stackTrace) {
      log("Excepción al eliminar una película: $e", stackTrace: stackTrace);
    }
    return 0;
  }
}
