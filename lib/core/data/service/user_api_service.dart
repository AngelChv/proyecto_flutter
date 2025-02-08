import 'package:proyecto_flutter/core/data/service/user_service.dart';
import 'package:proyecto_flutter/core/domain/user.dart';

class UserApiService implements UserService {
  @override
  Future<int?> insert(User user) async {
    return await 0;
  }

  @override
  Future<User?> login(String username, String password) async {
    return await User(id: 0, username: "angel", email: "angel@gmail.com");
  }

  @override
  Future<User?> findByUsername(String userName) async {
    return await User(id: 0, username: "angel", email: "angel@gmail.com");
  }
}