import 'package:flutter/material.dart';

import '../../../film/domain/film.dart';

class FilmCard extends StatelessWidget {
  const FilmCard({
    super.key,
    required this.film,
  });

  final Film film;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 9 / 16,
            child: Poster(
              imagePath: film.posterPath,
            ),
          ),
          Expanded(child: FilmInfo(film: film)),
        ],
      ),
    );
  }
}

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
          YearDurationText(year: film.year, duration: film.duration),
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
    return '${hours > 0 ? '$hours h' : ''} ${minutes > 0 ? '$minutes m' : ''}'
        .trim();
  }
}

class Poster extends StatelessWidget {
  const Poster({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      // Usa el mismo borderRadius que en la tarjeta
      child: Image.network(
        imagePath,
        alignment: Alignment.centerLeft,
        fit: BoxFit.cover,
      ),
    );
  }
}
