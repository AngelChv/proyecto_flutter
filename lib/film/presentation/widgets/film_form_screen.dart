import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form.dart';

import '../../../core/presentation/style_constants.dart';
import '../view_model/film_view_model.dart';

class FilmFormScreen extends StatefulWidget {
// Necesito que sea StateFul para poder manejar el contexto en la lambda
// asíncrona mediante context.mounted
  const FilmFormScreen({super.key, required this.isEditing});

  final bool isEditing;

  @override
  State<FilmFormScreen> createState() => _FilmFormScreenState();
}

class _FilmFormScreenState extends State<FilmFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final filmForm = FilmForm(_formKey);
    final isWideScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing ? "Editar película" : "Crear película"),
      ),
      body: Padding(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        child: filmForm,
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Crear Película",
        child: Icon(Icons.check),
        onPressed: () async {
          if (widget.isEditing) {
            // todo
          } else {
            final film = filmForm.submit();
            if (film != null) {
              if (!(await context.read<FilmViewModel>().createFilm(film)) && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error al crear la película")));
              } else if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Película creada")));
                context.pop();
              }
              // otro forma de usar snackbar
              //scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
            }
          }
        },
      ),
    );
  }
}
