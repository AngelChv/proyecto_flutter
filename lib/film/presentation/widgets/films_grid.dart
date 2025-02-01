import 'package:flutter/material.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';

import '../../domain/film.dart';
import 'film_card.dart';

/// Cuadrícula para mostrar las tarjetas de las películas.
class FilmsGrid extends StatelessWidget {
  const FilmsGrid({
    super.key,
    required films,
    void Function(Film film)? onFilmTap,
    void Function(Film film)? onFilmLongPress, EdgeInsetsGeometry? padding,
  })  : _padding = padding, _onFilmLongPress = onFilmLongPress,
        _onFilmTap = onFilmTap,
        _films = films;

  final List<Film> _films;
  final void Function(Film film)? _onFilmTap;
  final void Function(Film film)? _onFilmLongPress;
  final EdgeInsetsGeometry? _padding;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: _padding,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 600, // Ancho máximo de cada tarjeta
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16, // Espacio horizontal entre tarjetas
        mainAxisSpacing: 16, // Espacio vertical entre tarjetas
      ),
      itemCount: _films.length,
      itemBuilder: (context, index) {
        if (index == _films.length -1) return bottomSeparator;
        return FilmCard(
          onTap: _onFilmTap,
          onLongPress: _onFilmLongPress,
          film: _films[index],
        );
      },
    );
  }
}
