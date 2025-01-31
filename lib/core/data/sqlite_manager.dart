import 'dart:io' show Platform;

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../film/domain/film.dart';
import '../../film/data/repository/film_repository.dart';

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
    _db = await factory.openDatabase(dbPath);
    // Crear tablas si no existen:
    await _dataDefinition();
    //await _sampleData();
    return _db;
  }

  /// Crea las tablas si no existen
  static Future<void> _dataDefinition() async {
    final Database? db = await SqliteManager.db;
    db?.execute('''
        CREATE TABLE IF NOT EXISTS films (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          director TEXT NOT NULL,
          year INTEGER NOT NULL,
          duration INTEGER NOT NULL,
          description TEXT NOT NULL,
          poster_path TEXT
        )
      ''');
  }
}
