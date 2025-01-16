import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/ui/core/widgets/abstract_screen.dart';
import 'package:proyecto_flutter/ui/core/widgets/films_grid.dart';
import 'package:proyecto_flutter/ui/film/view_model/film_view_model.dart';

class FilmsScreen extends StatelessWidget implements AbstractScreen {
  @override
  final title = "Películas";
  @override
  final icon = Icons.local_movies;
  @override
  final appBarActions = const [
    Icon(Icons.search),
  ];

  const FilmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final films = context.watch<FilmViewModel>().films;

    return FilmsGrid(films: films);
  }
}
