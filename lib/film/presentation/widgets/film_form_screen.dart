import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form.dart';

import '../view_model/film_view_model.dart';

class FilmFormScreen extends StatelessWidget {
  const FilmFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Película"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FilmForm(
          onCompleteForm: (film) {
            context.read<FilmViewModel>().createFilm(film);

            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Película creada")));

            GoRouter.of(context).pop();
          },
        ),
      ),
    );
  }
}
