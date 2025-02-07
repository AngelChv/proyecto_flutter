import 'package:proyecto_flutter/core/data/service/user_service.dart';
import 'package:proyecto_flutter/core/domain/user.dart';
import 'package:sqflite/sqflite.dart';

class UserSqliteService implements UserService {
  static const String table = "user";

  static createDDL(Database db) async {
    db.execute("""
        CREATE TABLE IF NOT EXISTS $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL UNIQUE,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      );
      """);
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<int?> insert(User user) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<bool> update(User user) {
    // TODO: implement update
    throw UnimplementedError();
  }
}