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

  List<FilmsList> _lists = List.generate(100, (index) {
    return FilmsList(
        name: "Prueba",
        createDateTime: DateTime.now(),
        editDateTime: DateTime.now());
  });

  List<FilmsList> get lists => List.unmodifiable(_lists);

  FilmsList? _selectedList;

  FilmsList? get selectedList => _selectedList;

  ListViewModel() {
    loadLists();
  }

  void loadLists() {
    _listRepository.getAll().then((result) {
      _lists = result;
      notifyListeners();
    });
  }

  void selectList(FilmsList list) {
    _selectedList = list;
    notifyListeners();
  }

  getFilms() {
    // TODO: coger según el set de ids de la lista seleccionada, las correspondientes películas de la bd
  }

  createList(FilmsList newList) async {
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

  /// Valida el formulario y devuelve la nueva lista.
  /// Si el formulario no se valida devuelve null.
  /// Si al editar una lista no se modifica nada, devuelve null
  /// y lanza un snackbar.
  FilmsList? submitForm(BuildContext context, ListForm listForm, GlobalKey<FormState> formKey) {
    FilmsList? newList;
    if (formKey.currentState!.validate()) {
      final oldList = _selectedList;
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
