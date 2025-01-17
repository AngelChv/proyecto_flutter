import 'package:flutter/material.dart';
import '../../../film/presentation/widgets/films_screen.dart';
import '../../../list/presentation/widgets/lists_screen.dart';
import '../../../profile/presentation/widgets/profile_screen.dart';
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

  late AbstractScreen _currentPage;
  AbstractScreen get currentPage => _currentPage;

  AppViewModel() {
    _currentPage = _screens.first;
  }

  void changeNavigationPage(int value) {
    _currentPageIndex = value;
    _currentPage = _screens[value];
    notifyListeners();
  }

  void changePage(AbstractScreen screen) {
    _currentPage = screen;
    notifyListeners();
  }
}