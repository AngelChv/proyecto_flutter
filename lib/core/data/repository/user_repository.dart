import 'package:flutter/foundation.dart';
import 'package:proyecto_flutter/core/data/service/user_api_service.dart';
import 'package:proyecto_flutter/core/data/service/user_service.dart';
import 'package:proyecto_flutter/core/data/service/user_sqlite_service.dart';

import '../../domain/user.dart';

/// Se conecta a los servicios para gestionar los usuarios.
class UserRepository {
  late final UserService _userService;

  UserRepository() {
    if (kIsWeb) {
      _userService = UserApiService();
    } else {
      _userService = UserSqliteService();
    }
  }

  /// Inicia sesión con el nombre de usuario y contraseña indicados.
  Future<User?> login(String username, String password) {
    return _userService.login(username, password);
  }

  /// Crea una nueva cuenta de usuario.
  Future<int?> insert(User user) {
    return _userService.insert(user);
  }

  /// Comprueba si un nombre de usuario existe.
  Future<bool> existUsername(String username) async {
    return await _userService.findByUsername(username) != null;
  }
}