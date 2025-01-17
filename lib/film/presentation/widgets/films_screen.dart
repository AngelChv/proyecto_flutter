import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/domain/app_routes.dart';
import 'package:proyecto_flutter/core/presentation/widgets/films_grid.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';

class FilmsScreen extends StatelessWidget {
  const FilmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final films = context.watch<FilmViewModel>().films;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        // TODO: usar un recurso para el string
        title: Text("Películas"),
        // TODO: añadir actions (buscar...)
      ),
      body: FilmsGrid(films: films),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GoRouter.of(context).go(AppRoutes.addFilm);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
