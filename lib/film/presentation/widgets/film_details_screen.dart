import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_card.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../domain/film.dart';

/// Pantalla de detalles de la película
///
/// Muestra de manera extensa la información relevante.
/// Si el dispositivo tiene una pantalla compacta la información se muestra en
/// vertical, si es un dispositivo grande, se muestra en horizontal.
class FilmDetailsScreen extends StatelessWidget {
  const FilmDetailsScreen({super.key});

  _deleteFilm(BuildContext context, Film film) async {
    final isSuccess = await context.read<FilmViewModel>().deleteFilm(film);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isSuccess
              ? AppLocalizations.of(context)!.deletedFilm
              : AppLocalizations.of(context)!.deletingFilmError)));
      isSuccess ? context.pop() : null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: ResponsiveFilmDetails(),
    );
  }
}

class ResponsiveFilmDetails extends StatelessWidget {
  const ResponsiveFilmDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Todo: comprobar si no hay error al utilizar !
    final film = context.watch<FilmViewModel>().selectedFilm!;
    final height = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            width: double.infinity,
            child: Poster(imagePath: film.posterPath),
          ),
        ),
        SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: height,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.3, 0.6],
                colors: [
                  Colors.transparent,
                  Theme.of(context).scaffoldBackgroundColor.withValues(
                        alpha: 0.6,
                      ),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: height / 2,
              ),
              child: FilmDetailsInfo(),
            ),
          ),
        ),
      ],
    );
  }
}

class FilmDetailsInfo extends StatelessWidget {
  const FilmDetailsInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // Todo: comprobar si no hay error al utilizar !
    final film = context.watch<FilmViewModel>().selectedFilm!;
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 1200,
        ),
        padding: const EdgeInsets.all(compactMargin),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          spacing: 8,
          children: [
            Text(
              film.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              film.director,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            YearDurationText(
                year: film.year, duration: Duration(minutes: film.duration)),
            Text(film.description),
          ],
        ),
      ),
    );
  }
}
