import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/presentation/theme/style_constants.dart';
import '../../../film/presentation/view_model/film_view_model.dart';
import '../../../film/presentation/widgets/films_grid.dart';

class AddFilmsToListScreen extends StatelessWidget {
  const AddFilmsToListScreen({super.key, required FilmsList? selectedList})
      : _selectedList = selectedList;
  final FilmsList? _selectedList;

  _addFilmToList(BuildContext context, int? filmId) async {
    late ListResult? result;
    final listId = _selectedList?.id;
    if (filmId != null && listId != null) {
      result = await context.read<ListViewModel>().addFilmToList(
            listId,
            filmId,
          );
    }

    if (context.mounted) {
      late String message;
      // Crear mensaje en función del resultado.
      // todo personalizar mensajes
      if (result == null) {
        message = AppLocalizations.of(context)!.creatingFilmError;
      } else if (result.e is DatabaseException &&
          (result.e as DatabaseException).isUniqueConstraintError()) {
        // todo: mensaje: La película ya está en la lista.
        message = AppLocalizations.of(context)!.creatingFilmError;
      } else if (result.result is bool && result.result) {
        message = AppLocalizations.of(context)!.createFilm;
      } else {
        message = AppLocalizations.of(context)!.creatingFilmError;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

      // Volver si sale bien.
      if (result?.result is bool && result?.result) {
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    // Todo filtrar para quitar películas que ya están
    final films = context.watch<FilmViewModel>().films;

    return Scaffold(
      appBar: AppBar(
        // todo: cambiar titulo
        title: Text(AppLocalizations.of(context)!.films),
      ),
      body: FilmsGrid(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        onFilmTap: (film) {
          _addFilmToList(context, film.id);
        },
        onFilmLongPress: (film) {
        },
        films: films,
      ),
    );
  }
}
