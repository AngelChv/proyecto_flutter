import 'package:flutter/material.dart';

import '../../../domain/models/film.dart';
import 'film_card.dart';

class FilmsGrid extends StatelessWidget {
  const FilmsGrid({super.key, required films}) : _films = films;

  final List<Film> _films;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 600, // Ancho máximo de cada tarjeta
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16, // Espacio horizontal entre tarjetas
        mainAxisSpacing: 16, // Espacio vertical entre tarjetas
      ),
      itemCount: _films.length,
      itemBuilder: (context, index) {
        return FilmCard(
          film: _films[index],
        );
      },
    );
  }
}