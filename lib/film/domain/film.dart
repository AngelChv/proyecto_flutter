class Film {
  int? id; // el id será asignado por la base de datos cuando se recupere el objeto.
  final String title;
  final String director;
  final int year;
  final Duration duration;
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

  Map<String, Object?> toMap() {
    return {
      'title': title,
      'director': director,
      'year': year,
      'duration': duration.inMinutes,
      'description': description,
      'poster_path': posterPath,
    };
  }

  static Film fromMap(Map<String, dynamic> map) {
    return Film(
      id: map['id'],
      // El id se asigna cuando recuperamos el objeto desde la base de datos
      title: map['title'],
      director: map['director'],
      year: map['year'],
      duration: Duration(minutes: map['duration']),
      description: map['description'],
      posterPath: map['poster_path'],
    );
  }

  @override
  String toString() {
    return 'Film{id: $id, title: $title, director: $director, year: $year, duration: $duration, description: $description, posterPath: $posterPath}';
  }
}