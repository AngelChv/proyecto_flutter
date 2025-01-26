import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:proyecto_flutter/film/presentation/widgets/poster_picker.dart';
import 'package:proyecto_flutter/util/conversor.dart';
import '../../../core/presentation/theme/style_constants.dart';
import '../../domain/film.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FilmForm extends StatelessWidget {
  static const int _startYear = 1895;
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
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.title,
          labelText: AppLocalizations.of(context)!.title,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.insertTheTitle;
          }
          return null;
        },
      ),
      TextFormField(
        controller: _directorController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.director,
          labelText: AppLocalizations.of(context)!.director,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.insertTheDirector;
          }
          return null;
        },
      ),
      // TODO: añadir datepicker para el año
      TextFormField(
        controller: _yearController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.filmYear,
          labelText: AppLocalizations.of(context)!.filmYear,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.filmYear;
          }
          final year = int.tryParse(value);
          if (year == null || year < _startYear || year > DateTime.now().year) {
            return AppLocalizations.of(context)!.insertValidYear(
              DateTime.now().year,
              _startYear,
            );
          }
          return null;
        },
      ),
      TextFormField(
        readOnly: true,
        controller: _durationController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.clickDuration,
          border: OutlineInputBorder(),
        ),
        onTap: () async {
          final resultTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(minute: 1, hour: 0),
          );
          if (resultTime != null && context.mounted) {
            // TODO: creo que el format puede dar fallo con el pareTimeOfDay()
            _durationController.text = resultTime.format(context);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.insertDuration;
          }
          try {
            if (parseTimeOfDay(value).isAtSameTimeAs(TimeOfDay(
              hour: 0,
              minute: 0,
            ))) {
              throw Exception();
            }
            return null;
          } catch (e) {
            return AppLocalizations.of(context)!.insertValidDuration;
          }
        },
      ),
      TextFormField(
        controller: _descriptionController,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.description,
          labelText: AppLocalizations.of(context)!.description,
          border: OutlineInputBorder(),
        ),
        maxLines: 5,
        // Permite hasta 5 líneas de texto
        keyboardType: TextInputType.text,
        // Permite texto libre
        validator: (value) {
          if (value == null || value.isEmpty) {
            return AppLocalizations.of(context)!.insertDescription;
          }
          return null;
        },
      ),
      PosterPicker(),
    ];
  }

  void loadData(BuildContext context) {
    if (_isEditing) {
      final Film? film = context.watch<FilmViewModel>().selectedFilm;
      if (film != null) {
        _titleController.text = film.title;
        _directorController.text = film.director;
        _yearController.text = "${film.year}";
        _durationController.text =
            minutesToTimeOfDay(film.duration).format(context);
        _descriptionController.text = film.description;
        // Da error al realizar el notifyListeners mientras se ejecuta el build.
        context.read<FilmViewModel>().selectPoster(File(film.posterPath));
      }
    } else {
      context.read<FilmViewModel>().selectPoster(null);
    }
  }

  /// Valida el formulario y devuelve la nueva película.
  /// Si el formulario no se valida devuelve null.
  /// Si al editar una película no se modifica nada, devuelve null
  /// y lanza un snackbar.
  Film? submit(BuildContext context) {
    final FilmViewModel reader = context.read<FilmViewModel>();
    Film? newFilm;
    if (_formKey.currentState!.validate()) {
      final oldFilm = reader.selectedFilm;
      final duration = parseTimeOfDay(_durationController.text);
      final String? posterPath = reader.selectedPoster?.path;
      newFilm = Film(
        title: _titleController.text,
        director: _directorController.text,
        year: int.parse(_yearController.text.toString()),
        duration: timeOfDayToMinutes(duration),
        description: _descriptionController.text,
        // Todo: guardar las imágenes en el directorio de documentos de la app
        posterPath: posterPath ?? "https://placehold.co/900x1600/png",
      );

      // Comprobar si se ha modificado algo;
      if (newFilm == oldFilm) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.nothingHasBeenChanged),
          ),
        );
        newFilm = null;
      } else {
        reader.selectPoster(null);
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
