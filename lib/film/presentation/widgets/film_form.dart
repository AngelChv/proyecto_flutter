import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/view_model/film_view_model.dart';
import 'package:proyecto_flutter/film/presentation/widgets/poster_picker.dart';
import 'package:proyecto_flutter/util/conversor.dart';
import '../../../core/presentation/theme/style_constants.dart';
import '../../domain/film.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Formulario para crear o editar una película.
class FilmForm extends StatefulWidget {
  static const int _startYear = 1895;
  final GlobalKey<FormState> _formKey;
  final bool _isEditing;

  final _titleController = TextEditingController();

  String get title => _titleController.text;

  final _directorController = TextEditingController();

  String get director => _directorController.text;

  final _yearController = TextEditingController();

  String get year => _yearController.text;

  final _durationController = TextEditingController();

  String get duration => _durationController.text;

  final _descriptionController = TextEditingController();

  String get description => _descriptionController.text;

  FilmForm(this._formKey,
      {super.key, required bool isEditing, Film? editingFilm})
      : _isEditing = isEditing;

  @override
  State<FilmForm> createState() => _FilmFormState();
}

class _FilmFormState extends State<FilmForm> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData(context);
  }

  void loadData(BuildContext context) {
    if (widget._isEditing) {
      final Film? film = context.read<FilmViewModel>().selectedFilm;
      if (film != null) {
        widget._titleController.text = film.title;
        widget._directorController.text = film.director;
        widget._yearController.text = "${film.year}";
        widget._durationController.text =
            minutesToTimeOfDay(film.duration).format(context);
        widget._descriptionController.text = film.description;
        context.read<FilmViewModel>().selectPoster(File(film.posterPath));
      }
    } else {
      context.read<FilmViewModel>().selectPoster(null);
    }
  }

  @override
  void dispose() {
    widget._titleController.dispose();
    widget._directorController.dispose();
    widget._yearController.dispose();
    widget._durationController.dispose();
    widget._descriptionController.dispose();
    super.dispose();
  }

  List<Widget> buildFields(BuildContext context) {
    return [
      TextFormField(
        controller: widget._titleController,
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
        controller: widget._directorController,
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
        controller: widget._yearController,
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
          if (year == null ||
              year < FilmForm._startYear ||
              year > DateTime.now().year) {
            return AppLocalizations.of(context)!.insertValidYear(
              DateTime.now().year,
              FilmForm._startYear,
            );
          }
          return null;
        },
      ),
      TextFormField(
        readOnly: true,
        controller: widget._durationController,
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
            widget._durationController.text = timeOfDayToString(resultTime);
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
        controller: widget._descriptionController,
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
      bottomSeparator,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    final fields = buildFields(context);

    return Form(
      key: widget._formKey,
      child: ListView.separated(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        itemCount: fields.length,
        itemBuilder: (context, index) => fields[index],
        separatorBuilder: (context, index) => SizedBox(height: 12),
      ),
    );
  }
}
