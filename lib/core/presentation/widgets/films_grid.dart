import 'package:flutter/material.dart';

import '../../../film/domain/film.dart';
import 'film_card.dart';

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
      // todo el margen debería estar en FilmsScreen
      padding: _padding,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 600, // Ancho máximo de cada tarjeta
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 16, // Espacio horizontal entre tarjetas
        mainAxisSpacing: 16, // Espacio vertical entre tarjetas
      ),
      itemCount: _films.length,
      itemBuilder: (context, index) {
        return FilmCard(
          onTap: _onFilmTap,
          onLongPress: _onFilmLongPress,
          film: _films[index],
        );
      },
    );
  }
}
