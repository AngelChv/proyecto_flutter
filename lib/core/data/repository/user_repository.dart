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

  Future<bool> delete(int id) {
    return _userService.delete(id);
  }

  Future<List<User>> getAll() {
    return _userService.getAll();
  }

  Future<int?> insert(User user) {
    return _userService.insert(user);
  }

  Future<bool> update(User user) {
    return _userService.update(user);
  }
}