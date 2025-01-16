import 'package:flutter/material.dart';
import '../../film/widgets/films_screen.dart';
import '../../list/widgets/lists_screen.dart';
import '../../profile/widgets/profile_screen.dart';
import '../widgets/abstract_screen.dart';

class AppViewModel extends ChangeNotifier {
  final List<AbstractScreen> _screens = [
    FilmsScreen(),
    ListsScreen(),
    ProfileScreen(),
  ];
  List<AbstractScreen> get screens => _screens;

  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void changePage(int value) {
    _currentPageIndex = value;
    notifyListeners();
  }
}