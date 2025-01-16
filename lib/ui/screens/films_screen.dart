import 'package:flutter/material.dart';
import 'package:proyecto_flutter/ui/screens/abstract_screen.dart';

class FilmsScreen extends StatelessWidget implements AbstractScreen {
  @override
  final title = "Películas";
  @override
  final icon = Icons.local_movies;
  @override
  final appBarActions = const [
    Icon(Icons.search),
  ];

  const FilmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
