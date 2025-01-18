import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form.dart';

import '../../../core/presentation/style_constants.dart';
import '../view_model/film_view_model.dart';

class FilmFormScreen extends StatelessWidget {
  const FilmFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Película"),
      ),
      body: Padding(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
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
