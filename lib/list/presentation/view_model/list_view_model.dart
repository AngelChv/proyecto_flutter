import 'package:flutter/material.dart';
import 'package:proyecto_flutter/list/data/repository/list_repository.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Gestiona el estado de las listas.
///
/// **En desarrollo.**
class ListViewModel extends ChangeNotifier {
  final ListRepository _listRepository = ListRepository();

  List<FilmsList> _lists = [];

  List<FilmsList> get lists => List.unmodifiable(_lists);

  ListViewModel() {
    loadLists();
  }

  void loadLists() {
    _listRepository.getAll().then((result) {
      _lists = result;
      notifyListeners();
    });
  }

  getFilms() {
    // TODO: coger según el set de ids de la lista seleccionada, las correspondientes películas de la bd
  }

  Future<bool> createList(FilmsList newList) async {
    final int? id = await _listRepository.insert(newList);
    bool isSuccess = false;
    if (id != null) {
      newList.id = id;
      _lists.add(newList);
      isSuccess = true;
    }
    notifyListeners();
    return isSuccess;
  }

  Future<bool> deleteList(FilmsList list) async {
    if (list.id != null && await _listRepository.delete(list.id!)) {
    _lists.remove(list);
    notifyListeners();
    return true;
    }
    return false;
  }

  /// Valida el formulario y devuelve la nueva lista.
  /// Si el formulario no se valida devuelve null.
  /// Si al editar una lista no se modifica nada, devuelve null
  /// y lanza un snackbar.
  FilmsList? submitForm(BuildContext context, ListForm listForm, FilmsList? oldList) {
    FilmsList? newList;
    if (listForm.formKey.currentState!.validate()) {
      newList = FilmsList(
        name: listForm.name,
        createDateTime: DateTime.now(),
        editDateTime: DateTime.now(),
      );

      // Comprobar si se ha modificado algo;
      if (newList == oldList) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.nothingHasBeenChanged),
          ),
        );
        newList = null;
      }
    }
    return newList;
  }
}
