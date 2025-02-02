import 'package:sqflite/sqflite.dart';

import '../../domain/film.dart';
import 'film_service.dart';
import '../../../core/data/sqlite_manager.dart';

/// A través de una conexión a la base de datos realiza las operaciones indicadas.
///
/// Implementa la clase [FilmService] para asegurar tener los métodos crud
/// y que el repositorio pueda usar la interfáz para abstraerse del uso de
/// un servicio concreto.
class FilmSqliteService implements FilmService {
  static const String table = "films";

  static createDDL(Database db) async {
    db.execute("""
      CREATE TABLE IF NOT EXISTS $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          director TEXT NOT NULL,
          year INTEGER NOT NULL,
          duration INTEGER NOT NULL,
          description TEXT NOT NULL,
          poster_path TEXT
        );
      """
    );
  }

  /// Obtiene una lista con todas las películas.
  @override
  Future<List<Film>> getAll() async {
    List<Film> films = [];
    final Database? db = await SqliteManager.db;

    List<Map<String, Object?>>? resultList = await db?.query(table);
    if (resultList != null) {
      for (var result in resultList) {
        films.add(Film.fromMap(result));
      }
    }
    return films;
  }

  /// Inserta una película y devuelve su id generádo.
  @override
  Future<int?> insert(Film film) async {
    // todo manejar excepciones, en concreto id unique.
    final Database? db = await SqliteManager.db;
    return await db?.insert(table, film.toMap());
  }

  /// Actualiza una película y devuelve un `bool` con el resultado.
  @override
  Future<bool> update(Film film) async {
    final Database? db = await SqliteManager.db;
    final int? count = await db?.update(
        table,
        film.toMap(),
        where: "id = ?",
        whereArgs: [film.id]
    );

    return count == 1;
  }

  /// Elimina una película y devuelve un `bool` con el resultado.
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