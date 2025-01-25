import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/widgets/films_grid.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/presentation/style_constants.dart';

class FilmsScreen extends StatelessWidget {
  const FilmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 600;
    final films = context.watch<FilmViewModel>().films;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.films),
        // TODO: añadir actions (buscar...)
      ),
      body: FilmsGrid(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        onFilmTap: (film) {
          context.pushNamed("filmDetails");
        },
        onFilmLongPress: (film) {
          print("Longpress");
        },
        films: films,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: AppLocalizations.of(context)!.createFilm,
        onPressed: () async {
          final String? message = await context.pushNamed<String>("filmForm",
              pathParameters: {"isEditing": "false"});

          if (context.mounted && message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
            ));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
