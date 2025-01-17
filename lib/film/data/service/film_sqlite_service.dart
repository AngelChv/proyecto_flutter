import 'package:sqflite/sqflite.dart';

import '../../domain/film.dart';
import 'film_service.dart';
import '../../../core/data/sqlite_manager.dart';

class FilmSqliteService implements FilmService {
  @override
  Future<List<Film>> getAll() async {
    List<Film> films = [];
    final Database? db = await SqliteManager.db;

    List<Map<String, Object?>>? resultList = await db?.query("films");
    if (resultList != null) {
      for (var result in resultList) {
        films.add(Film.fromMap(result));
      }
    }
    return films;
  }

  @override
  Future<int?> insert(Film film) async {
    // todo manejar excepciones, en concreto id unique.
    final Database? db = await SqliteManager.db;
    return await db?.insert('films', film.toMap());
  }
}