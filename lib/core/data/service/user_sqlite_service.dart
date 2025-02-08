import 'package:proyecto_flutter/core/data/service/user_service.dart';
import 'package:proyecto_flutter/core/domain/user.dart';
import 'package:sqflite/sqflite.dart';

import '../sqlite_manager.dart';

/// Trabaja con la base de datos realizando las diferentes operaciones.
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

  /// Inicia sesión en sqlite.
  @override
  Future<User?> login(String username, String password) async {
    final Database? db = await SqliteManager.db;
    User? user;

    final List<Map<String, Object?>>? result = await db?.query(
      table,
      where: "username = ? AND password = ?",
      whereArgs: [username, password],
      limit: 1,
    );
    if (result != null && result.isNotEmpty) {
      user = User.fromMap(result.first);
    }

    return user;
  }

  /// Crea una cuenta nueva en sqlite.
  @override
  Future<int?> insert(User user) async {
    final Database? db = await SqliteManager.db;
    return await db?.insert(table, user.toMap());
  }

  /// Busca un usuario por su nombre.
  @override
  Future<User?> findByUsername(String userName) async {
    final Database? db = await SqliteManager.db;
    User? user;
    final List<Map<String, Object?>>? result = await db?.query(table,
    where: "username = ?",
    whereArgs: [userName]);
    if (result != null && result.isNotEmpty) {
      user = User.fromMap(result.first);
    }

    return user;
  }
}