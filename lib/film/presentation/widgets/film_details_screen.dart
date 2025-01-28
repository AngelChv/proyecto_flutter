import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_card.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/film.dart';

class FilmDetailsScreen extends StatelessWidget {
  const FilmDetailsScreen({super.key});

  _deleteFilm(BuildContext context, Film film) async {
    final isSuccess = await context.read<FilmViewModel>().deleteFilm(film);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isSuccess
              ? AppLocalizations.of(context)!.deletedFilm
              : AppLocalizations.of(context)!.deletingFilmError)
        )
      );
      isSuccess ? context.pop() : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;

    // Todo: comprobar si no hay error al utilizar !
    final film = context.watch<FilmViewModel>().selectedFilm!;
    return Scaffold(
      appBar: AppBar(
        title: Text(film.title),
        actions: [
          // TODO: usar un MenuAnchor por si no hay espacio para los actions
          // y que se muestren en un menú desplegable.
          IconButton(
            tooltip: AppLocalizations.of(context)!.editFilm,
            onPressed: () async {
              final String? message = await context.pushNamed<String>(
                  "filmForm",
                  pathParameters: {"isEditing": "true"});

              if (context.mounted && message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              }
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.deleteFilm,
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.askDeletingFilm),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(AppLocalizations.of(context)!.no),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                        _deleteFilm(context, film);
                      },
                      child: Text(AppLocalizations.of(context)!.yes),
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
            },
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
        YearDurationText(year: film.year, duration: Duration(minutes: film.duration)),
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
                YearDurationText(year: film.year, duration: Duration(minutes: film.duration)),
                Text(film.description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
