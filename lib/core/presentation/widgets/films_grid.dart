import 'package:flutter/material.dart';
import 'package:proyecto_flutter/core/presentation/style_constants.dart';

import '../../../film/domain/film.dart';
import 'film_card.dart';

class FilmsGrid extends StatelessWidget {
  const FilmsGrid({super.key, required films}) : _films = films;

  final List<Film> _films;

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 600;
    return GridView.builder(
      // todo el margen debería estar en FilmsScreen
      padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
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