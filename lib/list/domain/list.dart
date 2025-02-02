/// Define los datos que se necesitan para una lista y como se trabaja con ellos.
class FilmsList {
  int? id;
  // todo: el nombre sea unique
  final String name;
  final DateTime createDateTime;
  final DateTime editDateTime;
  // todo: ver como gestionar el añadir y eliminar las relaciones.
  final Set<int>? films;

  FilmsList({
    this.id,
    required this.name,
    required this.createDateTime,
    required this.editDateTime,
    this.films,
  });

  /// Transforma la lista a un mapa.
  ///
  /// El id se excluye para poder usarlo al insertar en sqlite y se
  /// genere un id auto incremental.
  Map<String, Object?> toMap() {
    return {
      "name": name,
      "create_date_time": createDateTime.toIso8601String(),
      "edit_date_time": createDateTime.toIso8601String(),
    };
  }

  /// Devuelve una película del mapa recibido como parámetro.
  ///
  /// Se necesitan los siguiéntes valores del mapa:
  /// 1. `int id`
  /// 2. `String name`
  /// 3. `String date_time` ([DateTime] en ISO 8601).
  static FilmsList fromMap(Map<String, dynamic> map) {
    return FilmsList(
      id: map["id"],
      name: map["name"],
      createDateTime: DateTime.parse(map["create_date_time"]),
      editDateTime: DateTime.parse(map["edit_date_time"]),
    );
  }

  /// Compara si dos listas son iguales.
  ///
  /// Compara por sus atributos no por la dirección de memoria.
  /// No se comprueba por id.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilmsList &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          createDateTime == other.createDateTime;

  @override
  int get hashCode => name.hashCode ^ createDateTime.hashCode;

  @override
  String toString() {
    return 'List{id: $id, name: $name, dateTime: $createDateTime}';
  }
}
