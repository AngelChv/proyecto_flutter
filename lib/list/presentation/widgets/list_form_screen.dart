import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';

class ListFormScreen extends StatelessWidget {
  ListFormScreen({
    super.key,
    FilmsList? oldList,
  }) : _oldList = oldList;

  final _formKey = GlobalKey<FormState>();
  final FilmsList? _oldList;

  @override
  Widget build(BuildContext context) {
    final listForm = ListForm(formKey: _formKey);
    final isEditing = _oldList != null;
    final userId = context.watch<UserViewModel>().currentUserId;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing
            // TODO: crear localizaciones para las listas.
            ? AppLocalizations.of(context)!.editFilm
            : AppLocalizations.of(context)!.createFilm),
      ),
      body: listForm,
      floatingActionButton: FloatingActionButton(
        tooltip: isEditing
            ? AppLocalizations.of(context)!.editFilm
            : AppLocalizations.of(context)!.createFilm,
        child: Icon(Icons.check),
        onPressed: () async {
          final newList = context.read<ListViewModel>().submitForm(
                context,
                listForm,
              );
          if (newList != null) {
            bool isSuccess;
            if (isEditing) {
              // Editing
              isSuccess = await context.read<ListViewModel>().editList(
                    newList,
                    _oldList,
                    userId,
                  );
            } else {
              // Creating
              isSuccess =
                  await context.read<ListViewModel>().createList(newList, userId);
            }

            if (isSuccess && context.mounted) {
              // TODO: cambiar localizaciones.
              context.pop<String>(isEditing
                  ? AppLocalizations.of(context)!.editedFilm
                  : AppLocalizations.of(context)!.createdFilm);
            } else if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(isEditing
                    ? AppLocalizations.of(context)!.editingFilmError
                    : AppLocalizations.of(context)!.creatingFilmError),
              ));
            }
          }
        },
      ),
    );
  }
}
