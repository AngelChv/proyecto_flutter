import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';

import '../../../core/presentation/theme/style_constants.dart';
import '../../../film/presentation/widgets/films_grid.dart';

class ListDetailsScreen extends StatelessWidget {
  const ListDetailsScreen({super.key});

  _deleteFilm(BuildContext context, FilmsList list) async {
    final isSuccess = await context.read<ListViewModel>().deleteList(list);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        // todo: cambiar localizaciones.
          content: Text(isSuccess
              ? AppLocalizations.of(context)!.deletedFilm
              : AppLocalizations.of(context)!.deletingFilmError)));
      isSuccess ? context.pop() : null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    final filteredFilms = context.watch<ListViewModel>().filmsOfList;
    // todo: comprobar si hay problemas al usar !
    final list = context.watch<ListViewModel>().selectedList!;

    return Scaffold(
      appBar: AppBar(
        // todo: al editar la lista no se esta modificando porque no depende del viewmodel
        title: Text(list.name),
        actions: [
          IconButton(
            tooltip: AppLocalizations.of(context)!.editFilm,
            onPressed: () async {
              final String? message = await context.pushNamed(
                  "listForm",
                  extra: list);

              if (context.mounted && message != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(message)),
                );
              }
            },
            icon: Icon(Icons.edit),
          ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.deleteFilm,
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(AppLocalizations.of(context)!.askDeletingFilm),
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
                        _deleteFilm(context, list);
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
        onFilmLongPress: (film) {
          // TODO: long press
        },
        films: filteredFilms,
      ),
      floatingActionButton: FloatingActionButton.extended(
        // Todo: usar localización adecuada (Añadir película)
        tooltip: AppLocalizations.of(context)!.createList,
        onPressed: () async {
/*
          final String? message = await context.pushNamed<String>("listForm",
              pathParameters: {"isEditing": "false"});

          if (context.mounted && message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
            ));
          }
*/
        },
        icon: Icon(Icons.add_box),
        // Todo: usar localización adecuada (Añadir película)
        label: Text(AppLocalizations.of(context)!.createList),
      ),
    );
  }
}
