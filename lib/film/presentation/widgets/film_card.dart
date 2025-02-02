import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/film.dart';
import '../view_model/film_view_model.dart';

/// Tarjeta que muestra la información de una película de una manera abreviada.
class FilmCard extends StatelessWidget {
  const FilmCard({
    super.key,
    required Film film,
    void Function(Film film)? onTap,
    void Function(Film film)? onLongPress,
  })  : _film = film,
        _onLongPress = onLongPress,
        _onTap = onTap;

  final void Function(Film film)? _onTap;
  final void Function(Film film)? _onLongPress;

  final Film _film;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FilmViewModel>().selectFilm(_film);
        if (_onTap != null) {
          _onTap(_film);
        }
      },
      onLongPress: () {
        if (_onLongPress != null) {
          _onLongPress(_film);
        }
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 9 / 16,
              child: Poster(
                imagePath: _film.posterPath,
              ),
            ),
            Expanded(child: FilmInfo(film: _film)),
          ],
        ),
      ),
    );
  }
}

/// Muestra de manera visual la información de una película.
///
/// Muestra:
/// 1. El título.
/// 2. El director.
/// 3. El año de estreno y la duración.
/// 4. La descripción.
class FilmInfo extends StatelessWidget {
  const FilmInfo({
    super.key,
    required this.film,
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            film.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            film.director,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          YearDurationText(
              year: film.year, duration: Duration(minutes: film.duration)),
          const Divider(),
          Flexible(
            child: Text(
              film.description,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}

/// Muestra el año de estreno y la duración de una película en horizontal.
class YearDurationText extends StatelessWidget {
  const YearDurationText({
    super.key,
    required this.year,
    required this.duration,
  });

  final int year;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text("$year"),
        const Text("\t|\t"),
        Text(formatDuration(duration)),
      ],
    );
  }

  String formatDuration(Duration duration) {
    // Convierte la duración a un formato legible (ej. 1h 30m)
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    // TODO: mirar si puedo usar una localización para esto
    return '${hours > 0 ? '$hours h' : ''} ${minutes > 0 ? '$minutes m' : ''}'
        .trim();
  }
}

/// Poster de una película con los bodes redondeados.
///
/// Se obtiene de la red o de un fichero en función de su protocolo.
class Poster extends StatelessWidget {
  const Poster({super.key, required this.imagePath});

  final String imagePath;

  bool _isNetworkPath(String path) {
    return path.startsWith("https://");
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      // Usa el mismo borderRadius que en la tarjeta
      child: _isNetworkPath(imagePath)
          ? Image.network(
              imagePath,
              alignment: Alignment.centerLeft,
              fit: BoxFit.cover,
            )
          : Image.file(
              File(imagePath),
              alignment: Alignment.centerLeft,
              fit: BoxFit.cover,
            ),
    );
  }
}
