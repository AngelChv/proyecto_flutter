import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';

import '../../../core/presentation/theme/style_constants.dart';
import '../../../film/presentation/view_model/film_view_model.dart';
import '../../../film/presentation/widgets/films_grid.dart';

class AddFilmsToListScreen extends StatelessWidget {
  const AddFilmsToListScreen({super.key, required FilmsList? selectedList})
      : _selectedList = selectedList;
  final FilmsList? _selectedList;

  _addFilmToList(BuildContext context, int? filmId) async {
    bool isSuccess = false;
    final listId = _selectedList?.id;
    if (filmId != null && listId != null) {
      isSuccess = await context.read<ListViewModel>().addFilmToList(
            listId,
            filmId,
          );
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          // Todo: cambiar texto
          content: Text(isSuccess
              ? AppLocalizations.of(context)!.createFilm
              : AppLocalizations.of(context)!.creatingFilmError)));
      isSuccess ? context.pop() : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    // Todo filtrar para quitar películas que ya están
    final films = context.watch<FilmViewModel>().films;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.films),
        // TODO: añadir actions (buscar...)
      ),
      body: FilmsGrid(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        onFilmTap: (film) {
          _addFilmToList(context, film.id);
        },
        onFilmLongPress: (film) {
          // TODO: long press
        },
        films: films,
      ),
    );
  }
}
