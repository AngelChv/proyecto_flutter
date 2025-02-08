import 'package:proyecto_flutter/core/domain/user.dart';

/// Clase abstracta que sirve para unificar los métodos de un servicio de usuario.
///
/// De esta forma independientemente de la fuente de los datos se pueden
/// realizar las mismas operaciones.
abstract class UserService {
  Future<User?> login(String username, String password);
  Future<User?> findByUsername(String userName);
  Future<int?> insert(User user);
}