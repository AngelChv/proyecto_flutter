import 'package:proyecto_flutter/film/data/service/film_sqlite_service.dart';
import 'package:proyecto_flutter/list/data/service/list_sqlite_service.dart';
import 'package:sqflite/sqflite.dart';

/// Se conecta a la base de datos para definir la relación.
class ListFilmsSqliteService {
  static const String table = "list_films";

  /// Crea la tabla de la relación entre películas y listas.
  static createDDL(Database db) async {
    db.execute("""
      CREATE TABLE IF NOT EXISTS $table (
        list_id INTEGER NOT NULL,
        film_id INTEGER NOT NULL,
        PRIMARY KEY (list_id, film_id),
        FOREIGN KEY (list_id) REFERENCES ${ListSqliteService.table}(id) ON DELETE CASCADE,
        FOREIGN KEY (film_id) REFERENCES ${FilmSqliteService.table}(id) ON DELETE CASCADE
      );
      """);
  }
}
