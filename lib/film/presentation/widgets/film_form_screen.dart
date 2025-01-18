import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form.dart';

import '../../../core/presentation/style_constants.dart';
import '../view_model/film_view_model.dart';

class FilmFormScreen extends StatefulWidget {

  const FilmFormScreen({super.key});

  @override
  State<FilmFormScreen> createState() => _FilmFormScreenState();
}

class _FilmFormScreenState extends State<FilmFormScreen> {
  final _formKey = GlobalKey<FormState>();

/*  submit() async {
    final film = _form.submit();
    if (film != null) {
      if (!(await context.read<FilmViewModel>().createFilm(film)) && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error al crear la película")));
      } else if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Película creada")));
        GoRouter.of(context).pop();
      }
      // otro forma de usar snackbar
      //scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
    }
  }*/
  @override
  Widget build(BuildContext context) {
    final filmForm = FilmForm(_formKey);
    final isWideScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Crear Película"),
      ),
      body: Padding(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        child: filmForm,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Crear Película",
        child: Icon(Icons.check),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            final film = filmForm.submit();
            if (film != null) {
              if (!(await context.read<FilmViewModel>().createFilm(film)) && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error al crear la película")));
              } else if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Película creada")));
                GoRouter.of(context).pop();
              }
              // otro forma de usar snackbar
              //scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
            }

/*
            final film = Film(
              title: filmForm.titleController.text,
              director: filmForm.directorController.text,
              year: int.parse(filmForm.yearController.text),
              description: filmForm.descriptionController.text,
              duration: Duration(minutes: 120),
              posterPath: "https://placehold.co/900x1600/png",
            );
*/

          }
        },
      ),
    );
  }
}
