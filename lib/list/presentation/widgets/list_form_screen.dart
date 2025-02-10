import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:proyecto_flutter/login/presentation/view_model/user_view_model.dart';

/// Pantalla que muestra el formulario de listas.
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
    final user = Provider.of<UserViewModel>(context, listen: false).currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing
            ? AppLocalizations.of(context)!.editList
            : AppLocalizations.of(context)!.createList),
      ),
      body: listForm,
      floatingActionButton: FloatingActionButton(
        heroTag: "listFormScreenFab",
        tooltip: isEditing
            ? AppLocalizations.of(context)!.editList
            : AppLocalizations.of(context)!.createList,
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
                    user?.token,
                    newList,
                    _oldList,
                  );
            } else {
              // Creating
              isSuccess = await context
                  .read<ListViewModel>()
                  .createList(user?.token, newList);
            }

            if (isSuccess && context.mounted) {
              context.pop<String>(isEditing
                  ? AppLocalizations.of(context)!.editedList
                  : AppLocalizations.of(context)!.createdList);
            } else if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(isEditing
                    ? AppLocalizations.of(context)!.editingListError
                    : AppLocalizations.of(context)!.creatingListError),
              ));
            }
          }
        },
      ),
    );
  }
}
