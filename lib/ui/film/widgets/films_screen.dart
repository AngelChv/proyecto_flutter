import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/ui/core/view_model/app_view_model.dart';
import 'package:proyecto_flutter/ui/core/widgets/abstract_screen.dart';
import 'package:proyecto_flutter/ui/core/widgets/films_grid.dart';
import 'package:proyecto_flutter/ui/film/view_model/film_view_model.dart';
import 'package:proyecto_flutter/ui/film/widgets/film_form_screen.dart';

class FilmsScreen extends StatelessWidget implements AbstractScreen {
  @override
  final title = "Películas";
  @override
  final icon = Icons.local_movies;
  @override
  final appBarActions = const [
    Icon(Icons.search),
  ];
  @override
  FloatingActionButton? floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read<AppViewModel>().changePage(FilmFormScreen());
      },
      child: Icon(Icons.add),
    );
  }

  const FilmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final films = context.watch<FilmViewModel>().films;

    return FilmsGrid(films: films);
  }
}
