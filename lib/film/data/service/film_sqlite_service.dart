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

  /// Crea la definición de la tabla.
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
      """);
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

  /// Obtiene una película por su id.
  ///
  /// Si no se encuentra devuelve null.
  @override
  Future<Film?> findById(int id) async {
    final Database? db = await SqliteManager.db;
    final result = await db?.query(
      table,
      where: "id = ?",
      whereArgs: [id],
      limit: 1
    );
    if (result == null || result.isEmpty) return null;
    return Film.fromMap(result.first);
  }

  /// Inserta una película y devuelve su id generádo.
  @override
  Future<int?> insert(Film film) async {
    final Database? db = await SqliteManager.db;
    return await db?.insert(table, film.toMap());
  }

  /// Actualiza una película y devuelve un `bool` con el resultado.
  @override
  Future<bool> update(Film film) async {
    final Database? db = await SqliteManager.db;
    final int? count = await db
        ?.update(table, film.toMap(), where: "id = ?", whereArgs: [film.id]);

    return count == 1;
  }

  /// Elimina una película y devuelve un `bool` con el resultado.
  @override
  Future<bool> delete(int id) async {
    final Database? db = await SqliteManager.db;
    final int count =
        await db?.delete(table, where: "id = ?", whereArgs: [id]) ?? 0;
    return count == 1;
  }

  /// Obtiene todas las películas de una lista por su id.
  @override
  Future<List<Film>> getFilmsByListId(int listId) async {
    final Database? db = await SqliteManager.db;

    final List<Map<String, Object?>>? resultList = await db?.rawQuery("""
    SELECT films.* FROM films
    JOIN list_films ON films.id = list_films.film_id
    WHERE list_films.list_id = ?
    """, [listId]);

    List<Film> films = [];
    if (resultList != null) {
      for (var result in resultList) {
        films.add(Film.fromMap(result));
      }
    }
    return films;
  }

  /// Obtiene el número total de películas guardadas.
  @override
  Future<int> countAllFilms() async {
    final Database? db = await SqliteManager.db;
    final result = await db?.rawQuery("SELECT COUNT(*) as count FROM $table");
    return result != null && result.isNotEmpty ? result.first['count'] as int : 0;
  }
}
