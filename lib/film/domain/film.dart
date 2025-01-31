/// Define los datos que se necesitan para una película y como se trabaja con ellos.
class Film {
  int? id; // el id será asignado por la base de datos cuando se recupere el objeto.
  final String title;
  final String director;
  final int year;
  final int duration;
  final String description;
  final String posterPath;

  Film({
    this.id, // El id es opcional al crear un nuevo objeto
    required this.title,
    required this.director,
    required this.year,
    required this.duration,
    required this.description,
    required this.posterPath,
  });

  /// Transforma la película a un mapa.
  ///
  /// El id se excluye para poder usarlo al insertar en sqlite y se
  /// genere un id auto incremental.
  Map<String, Object?> toMap() {
    return {
      'title': title,
      'director': director,
      'year': year,
      'duration': duration,
      'description': description,
      'poster_path': posterPath,
    };
  }

  /// Devuelve una película del mapa recibido como parámetro.
  ///
  /// Se necesitan los siguiéntes valores del mapa:
  /// 1. `int id`
  /// 2. `String title`
  /// 3. `String director`
  /// 4. `int year`
  /// 5. `int duration`
  /// 6. `String description`
  /// 7. `String posterPath`
  static Film fromMap(Map<String, dynamic> map) {
    return Film(
      id: map['id'],
      // El id se asigna cuando recuperamos el objeto desde la base de datos
      title: map['title'],
      director: map['director'],
      year: map['year'],
      duration: map['duration'],
      description: map['description'],
      posterPath: map['poster_path'],
    );
  }


  /// Compara si dos películas son iguales.
  ///
  /// Compara por sus atributos no por la dirección de memoria.
  /// No se comprueba por id.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Film &&
          runtimeType == other.runtimeType &&
          // Para comprobar si realmente se ha editado algo en el formulario
          // películas, tengo que omitir la comprobación del id,
          // debido a que la película nueva todavía no tiene.
          //id == other.id &&
          title == other.title &&
          director == other.director &&
          year == other.year &&
          duration == other.duration &&
          description == other.description &&
          posterPath == other.posterPath;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      director.hashCode ^
      year.hashCode ^
      duration.hashCode ^
      description.hashCode ^
      posterPath.hashCode;

  @override
  String toString() {
    return 'Film{id: $id, title: $title, director: $director, year: $year, duration: $duration, description: $description, posterPath: $posterPath}';
  }
}