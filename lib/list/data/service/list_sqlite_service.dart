import 'package:proyecto_flutter/list/data/service/list_service.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
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
        edit_date_time TEXT
      );
      """
    );
  }

  @override
  Future<List<FilmsList>> getAll() async {
    List<FilmsList> lists = [];
    final Database? db = await SqliteManager.db;

    List<Map<String, Object?>>? resultList = await db?.query(table);
    if (resultList != null) {
      for (var result in resultList) {
        lists.add(FilmsList.fromMap(result));
      }
    }
    return lists;
  }

  @override
  Future<int?> insert(FilmsList list) async {
    // todo manejar excepciones, en concreto id unique.
    final Database? db = await SqliteManager.db;
    return await db?.insert(table, list.toMap());
  }

  @override
  Future<bool> update(FilmsList list) async {
    final Database? db = await SqliteManager.db;
    final int? count = await db?.update(
        table,
        list.toMap(),
        where: "id = ?",
        whereArgs: [list.id]
    );

    return count == 1;
  }

  @override
  Future<bool> delete(int id) async {
    final Database? db = await SqliteManager.db;
    final int count = await db?.delete(
        table,
        where: "id = ?",
        whereArgs: [id]
    ) ?? 0;
    return count == 1;
  }
}