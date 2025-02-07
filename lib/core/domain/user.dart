class User {
  int? id;
  final String username;
  final String email;
  final String? password;

  User({
    this.id,
    required this.username,
    required this.email,
    this.password,
  });

  /// Transforma el User a un mapa.
  ///
  /// El id se excluye para poder usarlo al insertar en sqlite y se
  /// genere un id auto incremental.
  Map<String, Object?> toMap() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }

  /// Devuelve un User del mapa recibido como parámetro.
  ///
  /// Se necesitan los siguiéntes valores del mapa:
  /// 1. `int id`
  /// 2. `String username`
  /// 3. `String email`
  static User fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      // El id se asigna cuando recuperamos el objeto desde la base de datos
      username: map['username'],
      email: map['email'],
    );
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          username == other.username;

  @override
  int get hashCode => username.hashCode;

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email}';
  }
}
