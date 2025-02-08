import 'package:flutter/material.dart';
import 'package:proyecto_flutter/core/data/repository/user_repository.dart';
import 'package:proyecto_flutter/core/domain/user.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  User? _currentUser;

  // todo hacer que si el userId es nulo se haga logout
  int get currentUserId => _currentUser?.id ?? -1;

  bool get isAuthenticated => _currentUser != null;

  Future<bool> register(User user) async {
    final int? id = await _repository.insert(user);
    if (id == null) return false;
    user.id = id;
    _currentUser = user;
    notifyListeners();
    return true;
  }

  Future<bool> login(String username, String password) async {
    // todo: usar shared preferences para guardar la sesión.
    final user = await _repository.login(username, password);
    if (user != null) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> existUserName(String username) {
    return _repository.existUsername(username);
  }
}