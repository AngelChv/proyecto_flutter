import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/widgets/films_grid.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';
import '../../../core/presentation/theme/style_constants.dart';

/// Pantalla para visualizar las películas guardadas.
class FilmsScreen extends StatefulWidget {
  const FilmsScreen({super.key});

  @override
  State<FilmsScreen> createState() => _FilmsScreenState();
}

class _FilmsScreenState extends State<FilmsScreen> {
  @override
  void initState() {
    super.initState();
    final user = context.read<UserViewModel>().currentUser;
    if (user != null) {
      context.read<FilmViewModel>().loadFilms(user.token);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
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
        films: films,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "filmsScreenFab",
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
