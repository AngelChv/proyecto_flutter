import 'package:flutter/material.dart';
import 'package:proyecto_flutter/list/domain/list.dart';

/// Gestiona el estado de las listas.
///
/// **En desarrollo.**
class ListViewModel extends ChangeNotifier {
  final List<FilmsList> _lists = List.generate(100, (index) {
    return FilmsList(
        name: "Prueba",
        createDateTime: DateTime.now(),
        editDateTime: DateTime.now());
  });

  List<FilmsList> get lists => List.unmodifiable(_lists);

  FilmsList? _selectedList;

  FilmsList? get selectedList => _selectedList;

  ListViewModel() {
    // TODO: cargar listas de la db
  }

  selectList(FilmsList list) {
    _selectedList = list;
    notifyListeners();
  }

  getFilms() {
    // TODO: coger según el set de ids de la lista seleccionada, las correspondientes películas de la bd
  }
}
