import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/models/film.dart';
import '../repository/film_repository.dart';

class SqliteManager {
  static Database? _db;

  static Future<Database?> get db async {
    if (_db == null || !_db!.isOpen) return await startDb();
    return _db;
  }

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
    _dataDefinition();
    //_sampleData();
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
          year INTEGER,
          duration INTEGER NOT NULL,
          description TEXT NOT NULL,
          poster_path TEXT
        )
      ''');
  }

  static Future<void> _sampleData() async {
    final films = List<Film>.generate(1000, (int index) {
      return Film(
          title: "Film-$index",
          director: "Director",
          year: 1990,
          duration: Duration(hours: 1, minutes: 20),
          description:
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique vel felis nec dictum. Duis ligula lacus, pellentesque in quam nec, varius dignissim ex. Sed venenatis euismod facilisis. Donec placerat dolor sit amet diam dapibus vulputate. Sed cursus leo ipsum, nec malesuada augue accumsan aliquam. Integer faucibus diam ac magna ornare scelerisque vitae consectetur quam. Vivamus feugiat metus ultricies risus condimentum fermentum. Morbi massa sapien, malesuada nec hendrerit ac, dapibus id mauris. Phasellus scelerisque ex in odio suscipit pulvinar. Aliquam vitae felis sit amet nunc finibus facilisis. Duis viverra orci eget aliquam aliquet. Vestibulum ut auctor lacus. Curabitur vitae lacinia nisl. Proin eget rutrum lacus, id viverra eros. Curabitur et venenatis risus. Mauris lacus turpis, imperdiet a egestas bibendum, tincidunt in lacus.",
          posterPath: "https://placehold.co/900x1600/png");
    });

    for (var film in films) {
      FilmRepository().insert(film);
    }
  }
}
