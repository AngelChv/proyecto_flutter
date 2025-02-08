import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../view_model/film_view_model.dart';

/// Pantalla que muestra el formulario para editar o crear una película.
class FilmFormScreen extends StatefulWidget {
  const FilmFormScreen({super.key, required this.isEditing});

  final bool isEditing;

  @override
  State<FilmFormScreen> createState() => _FilmFormScreenState();
}

class _FilmFormScreenState extends State<FilmFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final filmForm = FilmForm(_formKey, isEditing: widget.isEditing);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditing
            ? AppLocalizations.of(context)!.editFilm
            : AppLocalizations.of(context)!.createFilm),
      ),
      body: filmForm,
      floatingActionButton: FloatingActionButton(
        heroTag: "filmFormFab",
        tooltip: widget.isEditing
            ? AppLocalizations.of(context)!.editFilm
            : AppLocalizations.of(context)!.createFilm,
        child: Icon(Icons.check),
        onPressed: () async {
          final film = context.read<FilmViewModel>().submitForm(context, filmForm, _formKey);
          if (film != null) {
            bool isSuccess;
            if (widget.isEditing) {
              isSuccess = await context.read<FilmViewModel>().editFilm(film);
            } else {
              isSuccess = await context.read<FilmViewModel>().createFilm(film);
            }

            if (isSuccess && context.mounted) {
              context.pop(widget.isEditing
                  ? AppLocalizations.of(context)!.editedFilm
                  : AppLocalizations.of(context)!.createdFilm);
            } else if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(widget.isEditing
                    ? AppLocalizations.of(context)!.editingFilmError
                    : AppLocalizations.of(context)!.creatingFilmError),
              ));
            }
            // otro forma de usar snackbar
            //scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
          }
        },
      ),
    );
  }
}
