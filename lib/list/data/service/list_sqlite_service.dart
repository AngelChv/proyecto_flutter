import 'package:proyecto_flutter/core/data/service/user_sqlite_service.dart';
import 'package:proyecto_flutter/list/data/service/list_service.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_sqlite_result.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/data/sqlite_manager.dart';

class ListSqliteService implements ListService {
  static const String table = "lists";

  static createDDL(Database db) async {
    db.execute("""
      CREATE TABLE IF NOT EXISTS $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        create_date_time TEXT,
        edit_date_time TEXT,
        user_id INTEGER NOT NULL,
        FOREIGN KEY (user_id) REFERENCES ${UserSqliteService.table}(id) ON DELETE CASCADE
      );
      """);
  }

  @override
  Future<List<FilmsList>> findAllByUserId(int userId) async {
    List<FilmsList> lists = [];
    final Database? db = await SqliteManager.db;

    List<Map<String, Object?>>? resultList = await db?.query(
      table,
      where: "user_id == ?",
      whereArgs: [userId],
    );
    if (resultList != null) {
      for (var result in resultList) {
        lists.add(FilmsList.fromMap(result));
      }
    }
    return lists;
  }

  @override
  Future<int?> insert(FilmsList list, int userId) async {
    final Database? db = await SqliteManager.db;
    return await db?.insert(table, list.toMap(userId));
  }

  @override
  Future<bool> update(FilmsList list, int userId) async {
    final Database? db = await SqliteManager.db;
    final int? count = await db?.update(
      table,
      list.toMap(userId),
      where: "id = ?",
      whereArgs: [list.id],
    );

    return count == 1;
  }

  @override
  Future<bool> delete(int id) async {
    final Database? db = await SqliteManager.db;
    final int count =
        await db?.delete(table, where: "id = ?", whereArgs: [id]) ?? 0;
    return count == 1;
  }

  @override
  Future<ListSqliteResult<bool>> addFilmToList(int listId, int filmId) async {
    final Database? db = await SqliteManager.db;
    try {
      final id = await db?.insert("list_films", {
            "list_id": listId,
            "film_id": filmId,
          }) ??
          -1;

      return ListSqliteResult(id > 0, null);
    } on DatabaseException catch (e) {
      return ListSqliteResult(false, e);
    }
  }

  @override
  Future<bool> removeFilmFromList(int listId, int filmId) async {
    final Database? db = await SqliteManager.db;
    final int count = await db?.delete(
          "list_films",
          where: "list_id = ? AND film_id = ?",
          whereArgs: [listId, filmId],
        ) ??
        0;
    return count > 0;
  }

  /// Obtiene el número total de películas guardadas.
  @override
  Future<int> countAllListsByUserId(int userId) async {
    final Database? db = await SqliteManager.db;
    final result = await db?.rawQuery(
      "SELECT COUNT(*) as count FROM $table WHERE user_id = $userId",
    );
    return result != null && result.isNotEmpty
        ? result.first['count'] as int
        : 0;
  }
}
