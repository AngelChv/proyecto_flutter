import 'package:flutter/material.dart';
import '../../domain/film.dart';

class FilmForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final _titleController = TextEditingController();
  final _directorController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();
  get directorController => _directorController;
  get yearController => _yearController;
  get descriptionController => _descriptionController;
  get titleController => _titleController;

  FilmForm(this._formKey, {super.key});

  Film? submit() {
    Film? film;
    if (_formKey.currentState!.validate()) {
      film = Film(
        title: _titleController.text,
        director: _directorController.text,
        year: int.parse(_yearController.text.toString()),
        duration: Duration(minutes: 1),
        description: _descriptionController.text,
        posterPath: "https://placehold.co/900x1600/png",
      );
    }
    return film;
  }

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
              final year = int.tryParse(value);
              if (year == null || year < 1895 || year > DateTime.now().year) {
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
            maxLines: 5,
            // Permite hasta 5 líneas de texto
            keyboardType: TextInputType.text,
            // Permite texto libre
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese una descripción';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
