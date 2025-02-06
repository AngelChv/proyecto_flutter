import 'package:flutter/material.dart';
import 'package:proyecto_flutter/film/data/repository/film_repository.dart';
import 'package:proyecto_flutter/list/data/repository/list_repository.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../film/domain/film.dart';

/// Gestiona el estado de las listas.
///
/// **En desarrollo.**
class ListViewModel extends ChangeNotifier {
  final ListRepository _listRepository = ListRepository();
  final FilmRepository _filmRepository = FilmRepository();

  List<FilmsList> _lists = [];

  List<FilmsList> get lists => List.unmodifiable(_lists);

  FilmsList? _selectedList;

  FilmsList? get selectedList => _selectedList;

  List<Film> _filmsOfList = [];

  List<Film> get filmsOfList => List.unmodifiable(_filmsOfList);

  selectList(FilmsList listToSelect) {
    _selectedList = listToSelect;
    notifyListeners();
    loadFilmsOfCurrentList();
  }

  ListViewModel() {
    loadLists();
  }

  void loadLists() {
    _listRepository.getAll().then((result) {
      _lists = result;
      notifyListeners();
    });
  }

  loadFilmsOfCurrentList() {
    if (_selectedList?.id != null) {
      _filmRepository.getFilmsByListId(_selectedList!.id!).then((result) {
        _filmsOfList = result;
        notifyListeners();
      });
    }
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

  /// Edita una lista y devuelve un `bool` con el resultado.
  ///
  /// Si la lista se modifica con éxito, la misma lista seleccionada
  /// se actualiza de la lista total y se actualiza la interfáz para mostrar el
  /// cambio.
  Future<bool> editList(FilmsList newList, FilmsList oldList) async {
    bool isSuccess = false;
    newList.id = oldList.id;
    isSuccess = await _listRepository.update(newList);
    if (isSuccess) {
      final int filmIndex = _lists.indexOf(oldList);
      if (filmIndex >= 0) {
        _lists[_lists.indexOf(oldList)] = newList;
        _selectedList = newList;
        notifyListeners();
      } else {
        isSuccess = false;
      }
    }
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

  Future<bool> addFilmToList(int listId, int filmId) async {
    final int? id = await _listRepository.addFilmToList(listId, filmId);
    bool isSuccess = false;
    if (id != null && _selectedList?.id == listId) {
      final film = await _filmRepository.findById(filmId);
      if (film != null) {
        _filmsOfList.add(film);
        isSuccess = true;
      }
    }
    notifyListeners();
    return isSuccess;
  }

  /// Valida el formulario y devuelve la nueva lista.
  /// Si el formulario no se valida devuelve null.
  /// Si al editar una lista no se modifica nada, devuelve null
  /// y lanza un snackbar.
  FilmsList? submitForm(BuildContext context, ListForm listForm) {
    FilmsList? newList;
    if (listForm.formKey.currentState!.validate()) {
      newList = FilmsList(
        name: listForm.name,
        // Todo: si se esta editando no sobreescribir la fecha de creación.
        createDateTime: DateTime.now(),
        editDateTime: DateTime.now(),
      );

      // Comprobar si se ha modificado algo;
      // todo: no funciona
      if (newList == _selectedList) {
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
