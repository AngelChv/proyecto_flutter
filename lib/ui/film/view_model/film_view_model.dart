import 'package:flutter/material.dart';
import 'package:proyecto_flutter/domain/models/film.dart';

class FilmViewModel extends ChangeNotifier {
  // Código provisional.
  final List<Film> _films = List.generate(1000, (index) {
    return Film(
      title: "Title-$index",
      director: "Director-$index",
      year: index,
      duration: Duration(minutes: index),
      description: "Descripción",
      posterPath: "https://placehold.co/900x1600/png",
    );
  });

  List<Film> get films => List.unmodifiable(_films);
}
