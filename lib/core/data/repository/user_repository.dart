import 'package:flutter/foundation.dart';
import 'package:proyecto_flutter/core/data/service/user_api_service.dart';
import 'package:proyecto_flutter/core/data/service/user_service.dart';
import 'package:proyecto_flutter/core/data/service/user_sqlite_service.dart';

import '../../domain/user.dart';

class UserRepository {
  late final UserService _userService;

  UserRepository() {
    if (kIsWeb) {
      _userService = UserApiService();
    } else {
      _userService = UserSqliteService();
    }
  }

  Future<User?> login(String username, String password) {
    return _userService.login(username, password);
  }

  Future<int?> insert(User user) {
    return _userService.insert(user);
  }

  Future<bool> existUsername(String username) async {
    return await _userService.findByUsername(username) != null;
  }
}