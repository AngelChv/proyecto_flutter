import 'package:flutter/material.dart';
import 'package:proyecto_flutter/core/domain/user.dart';

class UserViewModel extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  bool get isAuthenticated => _currentUser != null;

  login(String username, String password) {
    // todo conectarse con el repositorio
    // todo: usar shared preferences para guardar la sesión.
    final user = User(id: 0, username: "angel", email: "angel@gmail.com");
    _currentUser = user;
    notifyListeners();
  }
}