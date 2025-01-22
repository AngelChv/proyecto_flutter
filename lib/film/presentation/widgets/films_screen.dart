import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/widgets/films_grid.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';

class FilmsScreen extends StatelessWidget {
  const FilmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final films = context.watch<FilmViewModel>().films;

    return Scaffold(
      appBar: AppBar(
        // TODO: usar un recurso para el string
        title: Text("Películas"),
        // TODO: añadir actions (buscar...)
      ),
      body: FilmsGrid(
        onFilmTap: (film) {
          context.pushNamed("filmDetails");
        },
        onFilmLongPress: (film) {
          print("Longpress");
        },
        films: films,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Crear película",
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
