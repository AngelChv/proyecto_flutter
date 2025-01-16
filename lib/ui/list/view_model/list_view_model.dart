import 'package:flutter/material.dart';

class ListViewModel extends ChangeNotifier {
  // Código provisional.
  final Map<String, List<String>> _lists = {}; // Nombre de lista -> Películas
  Map<String, List<String>> get lists => Map.unmodifiable(_lists);

  void createList(String listName) {
    if (!_lists.containsKey(listName)) {
      _lists[listName] = [];
      notifyListeners();
    }
  }

  void addFilmToList(String listName, String film) {
    if (_lists.containsKey(listName)) {
      _lists[listName]?.add(film);
      notifyListeners();
    }
  }

  void removeFilmFromList(String listName, String film) {
    if (_lists.containsKey(listName)) {
      _lists[listName]?.remove(film);
      notifyListeners();
    }
  }
}
