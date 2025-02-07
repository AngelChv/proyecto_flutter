import 'package:proyecto_flutter/core/domain/user.dart';

abstract class UserService {
  Future<List<User>> getAll();
  Future<int?> insert(User user);
  Future<bool> update(User user);
  Future<bool> delete(int id);
}