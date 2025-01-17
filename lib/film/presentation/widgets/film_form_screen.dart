import 'package:flutter/material.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form.dart';


class FilmFormScreen extends StatelessWidget {
  const FilmFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FilmForm());
  }
}
