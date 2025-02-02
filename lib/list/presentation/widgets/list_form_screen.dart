import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListFormScreen extends StatelessWidget {
  ListFormScreen({super.key, required bool isEditing}) : _isEditing = isEditing;

  final bool _isEditing;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final listForm = ListForm(formKey: _formKey, idEditing: _isEditing);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing
        // TODO: crear localizaciones para las listas.
            ? AppLocalizations.of(context)!.editFilm
            : AppLocalizations.of(context)!.createFilm),
      ),
      body: listForm,
      floatingActionButton: FloatingActionButton(
        tooltip: _isEditing
            ? AppLocalizations.of(context)!.editFilm
            : AppLocalizations.of(context)!.createFilm,
        child: Icon(Icons.check),
        onPressed: () async {
          final film = context.read<ListViewModel>().submitForm(context, listForm, _formKey);
          if (film != null) {
            bool isSuccess;
            if (_isEditing) {
              // TODO: editar lista.
              //isSuccess = await context.read<ListViewModel>().editFilm(film);
              isSuccess = false;
            } else {
              isSuccess = await context.read<ListViewModel>().createList(film);
            }

            if (isSuccess && context.mounted) {
              // TODO: cambiar localizaciones.
              context.pop(_isEditing
                  ? AppLocalizations.of(context)!.editedFilm
                  : AppLocalizations.of(context)!.createdFilm);
            } else if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(_isEditing
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
