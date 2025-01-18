
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/style_constants.dart';
import 'package:proyecto_flutter/core/presentation/widgets/film_card.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';

class FilmDetailsScreen extends StatelessWidget {
  const FilmDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 600;

    // Todo: comprobar si no hay error al utilizar !
    final film = context.watch<FilmViewModel>().selectedFilm!;
    return Scaffold(
      appBar: AppBar(
        title: Text(film.title),
        actions: [
          IconButton(
            tooltip: "Editar película",
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          IconButton(
            tooltip: "Borrar película",
            onPressed: () {},
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return isWideScreen ? FilmDetailsExpanded() : FilmDetailsCompact();
        },
      ),
    );
  }
}

class FilmDetailsCompact extends StatelessWidget {
  const FilmDetailsCompact({super.key});

  @override
  Widget build(BuildContext context) {
    // Todo: comprobar si no hay error al utilizar !
    final film = context.watch<FilmViewModel>().selectedFilm!;

    return ListView(
      padding: EdgeInsets.all(compactMargin),
      children: [
        // todo: separar los hijos (ListView.Separated).
        Poster(imagePath: film.posterPath),
        Text(film.title),
        Text(film.director),
        YearDurationText(year: film.year, duration: film.duration),
        Text(film.description),
      ],
    );
  }
}

class FilmDetailsExpanded extends StatelessWidget {
  const FilmDetailsExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    // Todo: comprobar si no hay error al utilizar !
    final film = context.watch<FilmViewModel>().selectedFilm!;

    return Row(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: Poster(imagePath: film.posterPath),
          ),
        ),
        Expanded(
          flex: 2,
          child: Card(
            margin: EdgeInsets.all(mediumMargin),
            child: ListView(
              children: [
                Text(film.title),
                Text(film.director),
                YearDurationText(year: film.year, duration: film.duration),
                Text(film.description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
