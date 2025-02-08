import 'package:proyecto_flutter/core/domain/user.dart';

abstract class UserService {
  Future<User?> login(String username, String password);
  Future<User?> findByUsername(String userName);
  Future<int?> insert(User user);
}