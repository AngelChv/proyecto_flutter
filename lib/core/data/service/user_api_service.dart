import 'dart:convert';
import 'dart:developer';

import 'package:proyecto_flutter/core/data/service/user_service.dart';
import 'package:proyecto_flutter/core/domain/user.dart';
import 'package:http/http.dart' as http;

/// Se conecta a una apí para gestionar los usuarios.
///
/// Este código es provisional, solo sirve para falsear el funcionamiento
/// de una api.
class UserApiService implements UserService {
  static const String urlBase = "http://127.0.0.1:8000/users";

  @override
  Future<int?> insert(User user) async {
    final url = Uri.parse("$urlBase/register");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toMap()),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as int;
      }
      if (response.statusCode == 400) {
        log("El nombre de usuario ya existe");
      }
    } catch (e, stackTrace) {
      log("Excepción al crear una cuenta: $e", stackTrace: stackTrace);
    }
    return null;
  }

  @override
  Future<User?> login(String username, String password) async {
    final url = Uri.parse("$urlBase/login");
    final loginUser = User(username: username, email: "", password: password);
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(loginUser.toLoginMap()),
      );
      if (response.statusCode == 200) {
        return User.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      }
    } catch (e, stackTrace) {
      log("Excepción al iniciar sesión: $e", stackTrace: stackTrace);
    }
    return null;
  }

  @override
  Future<User?> findByUsername(String userName) async {
    final url = Uri.parse("$urlBase/$userName");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return User.fromMap(jsonDecode(response.body) as Map<String, dynamic>);
      }
    } catch (e, stackTrace) {
      log("Excepción al obtener un usuario por nombre: $e", stackTrace: stackTrace);
    }
    return null;
  }
}