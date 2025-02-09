import 'package:proyecto_flutter/core/data/service/user_sqlite_service.dart';
import 'package:proyecto_flutter/list/data/service/list_service.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_sqlite_result.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/data/sqlite_manager.dart';


/// A través de una conexión a la base de datos realiza las operaciones indicadas.
///
/// Implementa la clase [ListService] para asegurar tener los métodos crud
/// y que el repositorio pueda usar la interfáz para abstraerse del uso de
/// un servicio concreto.
class ListSqliteService implements ListService {
  static const String table = "lists";

  /// Crea la definición de la tabla.
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

  /// Obtiene una lista con todas las listas del usuario por su id.
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

  /// Inserta una lista y devuelve su id generádo.
  @override
  Future<int?> insert(FilmsList list, int userId) async {
    final Database? db = await SqliteManager.db;
    return await db?.insert(table, list.toMapWithoutId(userId));
  }

  /// Actualiza una lista y devuelve un `bool` con el resultado.
  @override
  Future<bool> update(FilmsList list, int userId) async {
    final Database? db = await SqliteManager.db;
    final int? count = await db?.update(
      table,
      list.toMapWithoutId(userId),
      where: "id = ?",
      whereArgs: [list.id],
    );

    return count == 1;
  }

  /// Elimina una lista y devuelve un `bool` con el resultado.
  @override
  Future<bool> delete(int id) async {
    final Database? db = await SqliteManager.db;
    final int count =
        await db?.delete(table, where: "id = ?", whereArgs: [id]) ?? 0;
    return count == 1;
  }

  /// Añade una película a una lista por sus ids.
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

  /// Elimina una película de una lista por sus ids.
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
