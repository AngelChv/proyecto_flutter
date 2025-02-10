import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';

import '../../../core/presentation/theme/style_constants.dart';
import '../../../film/domain/film.dart';
import '../../../film/presentation/widgets/films_grid.dart';

/// Pantalla que muestra las películas de una lista.
///
/// Medíante las acciones del toolbar permite modificar o eliminar la lista.
/// Mediante el FAB permite ir a la pantalla de añadir películas.
/// Cada tarjeta de película tiene un botón para eliminarla de la lista.
class ListDetailsScreen extends StatelessWidget {
  const ListDetailsScreen({super.key});

  _deleteList(BuildContext context, FilmsList list) async {
    final user = context.read<UserViewModel>().currentUser;
    final isSuccess =
        await context.read<ListViewModel>().deleteList(user?.token, list);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(isSuccess
              ? AppLocalizations.of(context)!.deletedList
              : AppLocalizations.of(context)!.deletingListError)));
      isSuccess ? context.pop() : null;
    }
  }

  _showRemoveFilmFromListDialog(BuildContext context, int listId, Film film) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.askDeletingFilmFromList),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text(AppLocalizations.of(context)!.no),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              _removeFilmFromList(context, listId, film);
            },
            child: Text(AppLocalizations.of(context)!.yes),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  _removeFilmFromList(BuildContext context, int listId, Film film) async {
    final user = context.read<UserViewModel>().currentUser;
    final isSuccess = await context.read<ListViewModel>().removeFilmFromList(
          user?.token,
          listId,
          film,
        );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isSuccess
            ? AppLocalizations.of(context)!.deletedFilmFromList
            : AppLocalizations.of(context)!.deletingFilmFromListError),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    final filteredFilms = context.watch<ListViewModel>().filmsOfList;
    final list = context.watch<ListViewModel>().selectedList!;

    return Scaffold(
      appBar: AppBar(
        title: Text(list.name),
        actions: [
          IconButton(
            tooltip: AppLocalizations.of(context)!.editList,
            onPressed: () async {
              final String? message =
                  await context.pushNamed("listForm", extra: list);

              if (context.mounted && message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              }
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.deleteList,
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.askDeletingList),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: Text(AppLocalizations.of(context)!.no),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                        _deleteList(context, list);
                      },
                      child: Text(AppLocalizations.of(context)!.yes),
                    ),
                  ],
                ),
                barrierDismissible: false,
              );
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: FilmsGrid(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        onFilmTap: (film) {
          context.pushNamed("filmDetails");
        },
        films: filteredFilms,
        showDeleteButton: true,
        onDeleteClick: (film) {
          if (list.id != null) {
            _showRemoveFilmFromListDialog(context, list.id!, film);
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "listDetailsScreenFab",
        tooltip: AppLocalizations.of(context)!.addFilmToList,
        onPressed: () async {
          context.pushNamed<FilmsList>("addFilmToList", extra: list);
        },
        icon: Icon(Icons.add_box),
        label: Text(AppLocalizations.of(context)!.addFilmToList),
      ),
    );
  }
}
