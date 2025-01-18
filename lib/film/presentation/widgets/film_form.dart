import 'dart:ui';

import 'package:flutter/material.dart';

import '../../domain/film.dart';

class FilmForm extends StatefulWidget {
  const FilmForm({super.key, required this.onCompleteForm});

  final void Function(Film film) onCompleteForm;

  @override
  State<FilmForm> createState() => _FilmFormState();
}

class _FilmFormState extends State<FilmForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _directorController = TextEditingController();
  final _yearController = TextEditingController();
  int? _year;
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 24,
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: "Título",
              labelText: "Título",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Introduzca el título";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _directorController,
            decoration: const InputDecoration(
              hintText: "Director",
              labelText: "Director",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Introduzca el director";
              }
              return null;
            },
          ),
          TextFormField(
            controller: _yearController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Año del estreno",
              labelText: "Año del estreno, ej: (2010)",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Introduzca el año de estreno";
              }
              _year = int.tryParse(value);
              if (_year == null || _year! < 1895 || _year! > DateTime.now().year) {
                return 'Por favor ingrese un año válido entre 1895 y ${DateTime.now().year}';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              hintText: "Ingrese una descripción",
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,  // Permite hasta 5 líneas de texto
            keyboardType: TextInputType.text,  // Permite texto libre
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una descripción';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final Film film = Film(
                  title: _titleController.text,
                  director: _directorController.text,
                  year: _year!,
                  duration: Duration(minutes: 1),
                  description: _descriptionController.text,
                  posterPath: "https://placehold.co/900x1600/png",
                );
                widget.onCompleteForm(film);
              }
            },
            child: const Text("Crear"),
          ),
        ],
      ),
    );
  }
}
