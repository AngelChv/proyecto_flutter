import 'package:flutter/material.dart';
import 'package:proyecto_flutter/core/data/repository/user_repository.dart';
import 'package:proyecto_flutter/core/domain/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Gestiona el estado de la autenticación.
///
/// Guarda la sesión actual y permite cerrarla.
///
/// La sesión permanece gracias a [SharedPreferences].
class UserViewModel extends ChangeNotifier {
  final UserRepository _repository = UserRepository();
  User? _currentUser;

  User? get currentUser => _currentUser;

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
    final user = await _repository.login(username, password);
    if (user != null) {
      _currentUser = user;
      notifyListeners();
      _saveSession(username, password);
      return true;
    }
    return false;
  }

  Future<bool?> loadSession() async {
    final preferences = await SharedPreferences.getInstance();
    final username = preferences.getString("username");
    final password = preferences.getString("password");
    if (username != null && password != null) {
      return await login(username, password);
    }
    return null;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
    _removeSession();
  }

  Future<bool> existUserName(String username) {
    return _repository.existUsername(username);
  }

  void _saveSession(String username, String password) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("username", username);
    preferences.setString("password", password);
  }

  Future<void> _removeSession() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove("username");
    preferences.remove("password");
  }
}