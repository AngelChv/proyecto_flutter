import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';

import '../../domain/film.dart';

class FilmForm extends StatefulWidget {
  const FilmForm({super.key});

  @override
  State<FilmForm> createState() => _FilmFormState();
}

class _FilmFormState extends State<FilmForm> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final directorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: const InputDecoration(hintText: "Título"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Introduzca un título";
              }
              return null;
            },
          ),
          TextFormField(
            controller: directorController,
            decoration: const InputDecoration(hintText: "Director"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Introduzca un título";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context.read<FilmViewModel>().createFilm(Film(
                      title: titleController.text,
                      director: directorController.text,
                      year: 1,
                      duration: Duration(minutes: 1),
                      description: "hola",
                      posterPath: "https://placehold.co/900x1600/png",
                    ));
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Película creada")));
              }
            },
            child: const Text("Enviar"),
          ),
        ],
      ),
    );
  }
}
