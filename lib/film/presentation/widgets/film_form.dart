import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:proyecto_flutter/util/conversor.dart';
import '../../../core/presentation/style_constants.dart';
import '../../domain/film.dart';

class FilmForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final bool _isEditing;
  final _titleController = TextEditingController();
  final _directorController = TextEditingController();
  final _yearController = TextEditingController();
  // Si no uso un controller tendría un valor no final en un stateless
  // y no puede ser el formulario stateful para poder acceder a submit()
  final _durationController = TextEditingController();
  final _descriptionController = TextEditingController();

  get directorController => _directorController;

  get yearController => _yearController;

  get descriptionController => _descriptionController;

  get titleController => _titleController;

  FilmForm(this._formKey, {super.key, required bool isEditing})
      : _isEditing = isEditing;

  List<Widget> buildFields(BuildContext context) {
    return [
      // TODO: añadir timePicker para la duración.
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
      // TODO: añadir datepicker para el año
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
        readOnly: true,
        controller: _durationController,
        decoration: InputDecoration(
          hintText: "Haga click para introducir la duración",
          border: OutlineInputBorder(),
        ),
        onTap: () async {
          final resultTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(minute: 1, hour: 0),
          );
          if (resultTime != null) {
            // Todo: intentar hacer el widget stateful para usar context.mounted
            // TODO: creo que el format puede dar fallo con el pareTimeOfDay()
            _durationController.text = resultTime.format(context);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Introduzca una duración";
          }
          try {
            parseTimeOfDay(value);
            return null;
          } catch (e) {
            return 'Por favor ingrese una duración válida';
          }
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
    ];
  }

  void loadData(BuildContext context) {
    if (_isEditing) {
      final Film? film = context.watch<FilmViewModel>().selectedFilm;
      if (film != null) {
        _titleController.text = film.title;
        _directorController.text = film.director;
        _yearController.text = "${film.year}";
        _durationController.text = minutesToTimeOfDay(film.duration).format(context);
        _descriptionController.text = film.description;
      }
    }
  }

  /// Valida el formulario y devuelve la nueva película.
  /// Si el formulario no se valida devuelve null.
  /// Si al editar una película no se modifica nada, devuelve null
  /// y lanza un snackbar.
  Film? submit(BuildContext context) {
    Film? newFilm;
    if (_formKey.currentState!.validate()) {
      final oldFilm = context.read<FilmViewModel>().selectedFilm;
      final duration = parseTimeOfDay(_durationController.text);
      newFilm = Film(
        title: _titleController.text,
        director: _directorController.text,
        year: int.parse(_yearController.text.toString()),
        duration: timeOfDayToMinutes(duration),
        description: _descriptionController.text,
        posterPath: "https://placehold.co/900x1600/png",
      );

      // Comprobar si se ha modificado algo;
      if (newFilm == oldFilm) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No se ha modificado nada"),
          ),
        );
        newFilm = null;
      }
    }
    return newFilm;
  }

  @override
  Widget build(BuildContext context) {
    final bool isWideScreen = MediaQuery.of(context).size.width > 600;
    loadData(context);
    final fields = buildFields(context);

    return Form(
      key: _formKey,
      child: ListView.separated(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        itemCount: fields.length,
        itemBuilder: (context, index) => fields[index],
        separatorBuilder: (context, index) => SizedBox(height: 12),
      ),
    );
  }
}
