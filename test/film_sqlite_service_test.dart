import 'package:flutter_test/flutter_test.dart';
import 'package:proyecto_flutter/film/data/service/film_sqlite_service.dart';
import 'package:proyecto_flutter/film/domain/film.dart';

void main() {
  late FilmSqliteService filmService;
  final film = Film(
    id: null,
    title: 'Inception',
    director: 'Christopher Nolan',
    year: 2010,
    duration: 148,
    description: 'A mind-bending thriller',
    posterPath: 'https://placehold.co/900x1600/png',
  );

  setUp(() async {
    filmService = FilmSqliteService();
  });

  test('Debe insertar y recuperar una película', () async {
    film.id = await filmService.insert(film);
    expect(film.id, isNotNull);

    final Film? retrievedFilm = await filmService.findById(film.id!);
    expect(retrievedFilm, isNotNull);
    expect(retrievedFilm?.title, 'Inception');
  });

  test('Debe actualizar una película existente', () async {
    final updatedFilm = Film(
      id: film.id,
      title: "${film.title} (Actualizado)",
      director: film.director,
      year: film.year,
      duration: film.duration,
      description: film.description,
      posterPath: film.posterPath,
    );

    final bool updated = await filmService.update(updatedFilm);
    expect(updated, isTrue);

    final Film? retrievedFilm = await filmService.findById(updatedFilm.id!);
    expect(retrievedFilm?.title, 'Inception (Actualizado)');
  });

  test('Debe eliminar una película', () async {

    final bool deleted = await filmService.delete(film.id!);
    expect(deleted, isTrue);

    final Film? retrievedFilm = await filmService.findById(film.id!);
    expect(retrievedFilm, isNull);
  });
}
