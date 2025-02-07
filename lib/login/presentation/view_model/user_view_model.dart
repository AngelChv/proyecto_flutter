import 'package:flutter/material.dart';
import 'package:proyecto_flutter/core/domain/user.dart';

class UserViewModel extends ChangeNotifier {
  User? _currentUser;

  // todo hacer que si el userId es nulo se haga logout
  int get currentUserId => _currentUser?.id ?? logout();

  bool get isAuthenticated => _currentUser != null;

  login(String username, String password) {
    // todo conectarse con el repositorio
    // todo: usar shared preferences para guardar la sesión.
    final user = User(id: 0, username: "angel", email: "angel@gmail.com");
    _currentUser = user;
    notifyListeners();
  }

  logout() {
  }
}