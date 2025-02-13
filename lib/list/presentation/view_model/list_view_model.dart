import 'package:flutter/material.dart';
import 'package:proyecto_flutter/film/data/repository/film_repository.dart';
import 'package:proyecto_flutter/list/data/repository/list_repository.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../film/domain/film.dart';

/// Gestiona el estado de las listas.
///
/// **En desarrollo.**
class ListViewModel extends ChangeNotifier {
  final ListRepository _listRepository = ListRepository();
  final FilmRepository _filmRepository = FilmRepository();

  late int _currentUserId;

  set currentUserId(int value) {
    _currentUserId = value;
    loadLists();
  }

  List<FilmsList>? _lists;

  /// Obtiene las listas, si no están cargadas hace una petición.
  List<FilmsList>? getLists() {
    if (_lists != null) return _lists!;
    return loadLists();
  }

  FilmsList? _selectedList;

  /// Lista seleccionada.
  FilmsList? get selectedList => _selectedList;

  List<Film> _filmsOfList = [];

  /// Películas de la lista seleccionada.
  List<Film> get filmsOfList => _filmsOfList;

  /// Selecciona una lista.
  selectList(FilmsList listToSelect) {
    _selectedList = listToSelect;
    notifyListeners();
    loadFilmsOfCurrentList();
  }

  /// Carga las listas del repositorio.
  ///
  /// Puede ser una petición a una api o a sqlite.
  List<FilmsList>? loadLists() {
    _listRepository.findAllByUserId(_currentUserId).then((result) {
      _lists = result;
      notifyListeners();
    });
    return _lists;
  }

  /// Carga las películas de la lista seleccionada.
  loadFilmsOfCurrentList() {
    if (_selectedList?.id != null) {
      _filmRepository.getFilmsByListId(_selectedList!.id!).then((result) {
        _filmsOfList = result;
        notifyListeners();
      });
    }
  }

  /// Crea una lista
  Future<bool> createList(FilmsList newList) async {
    final int? id = await _listRepository.insert(newList, _currentUserId);
    bool isSuccess = false;
    if (id != null) {
      newList.id = id;
      _lists?.add(newList);
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
    isSuccess = await _listRepository.update(newList, _currentUserId);
    if (isSuccess && _lists != null) {
      final int filmIndex = _lists?.indexOf(oldList) ?? -1;
      if (filmIndex >= 0) {
        _lists?[_lists!.indexOf(oldList)] = newList;
        _selectedList = newList;
        notifyListeners();
      } else {
        isSuccess = false;
      }
    }
    return isSuccess;
  }

  /// Elimina una lista
  Future<bool> deleteList(FilmsList list) async {
    if (list.id != null && await _listRepository.delete(list.id!) && _lists != null) {
      _lists?.remove(list);
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Añade una película a la lista.
  Future<ListResult<bool>> addFilmToList(int listId, int filmId) async {
    final ListResult<bool> result = await _listRepository.addFilmToList(
        listId, filmId);

    // Añadir película a la lista en memoria.
    if (result.result && _selectedList?.id == listId) {
      final film = await _filmRepository.findById(filmId);
      if (film != null) {
        _filmsOfList.add(film);
      }
    }
    notifyListeners();
    return result;
  }

  /// Elimina una película de la lista.
  Future<bool> removeFilmFromList(int listId, Film film) async {
    if (film.id == null) return false;
    final isSuccess = await _listRepository.removeFilmFromList(
        listId, film.id!);
    if (isSuccess && _selectedList?.id == listId) {
      _filmsOfList.remove(film);
      notifyListeners();
      return true;
    }
    return false;
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
