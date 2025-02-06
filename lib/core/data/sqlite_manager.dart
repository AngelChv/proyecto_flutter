import 'dart:io' show Platform;

import 'package:path/path.dart';
import 'package:proyecto_flutter/core/data/list_films_sqlite_service.dart';
import 'package:proyecto_flutter/film/data/service/film_sqlite_service.dart';
import 'package:proyecto_flutter/list/data/service/list_sqlite_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Gestiona la conexión a la base de datos.
///
/// Sirve para:
/// * Android.
/// * IOS.
/// * Windows.
///
/// A través de [db] se obtiene la conexión.
class SqliteManager {
  static Database? _db;

  /// Devuelve la conexión a la base de datos.
  ///
  /// Si ya hay una creada, se devuelve la misma, si no hay ninguna, se
  /// crea una nueva.
  static Future<Database?> get db async {
    if (_db == null || !_db!.isOpen) return await startDb();
    return _db;
  }

  /// Crea una nueva conexión a la base de datos.
  static Future<Database?> startDb() async {
    // Configuración de FFI
    sqfliteFfiInit();

    DatabaseFactory factory;

    if (!(Platform.isAndroid || Platform.isIOS)) {
      // Crear la fábrica de bases de datos FFI
      factory = databaseFactoryFfi;
    } else {
      // Creo la fábrica de sqflite
      factory = databaseFactory;
    }

    // Abrir o crear una base de datos
    final dbPath = join(await factory.getDatabasesPath(), 'film.db');
    _db = await factory.openDatabase(dbPath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) {
            _dataDefinition(db);
          },
        ));
    return _db;
  }

  /// Crea las tablas si no existen
  static Future<void> _dataDefinition(Database db) async {
    FilmSqliteService.createDDL(db);
    ListSqliteService.createDDL(db);
    ListFilmsSqliteService.createDDL(db);
  }
}
