import 'package:flutter/material.dart';
import 'package:proyecto_flutter/film/presentation/widgets/film_form.dart';

import '../../../core/presentation/widgets/abstract_screen.dart';

class FilmFormScreen extends StatelessWidget implements AbstractScreen {
  @override
  final title = "Crear película";
  @override
  final icon = Icons.movie;
  @override
  final appBarActions = const [];
  @override
  floatingActionButton(_) {
    return null;
  }

  const FilmFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FilmForm();
  }
}
