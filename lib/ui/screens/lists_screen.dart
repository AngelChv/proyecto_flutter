import 'package:flutter/material.dart';
import 'package:proyecto_flutter/ui/screens/abstract_screen.dart';

class ListsScreen extends StatelessWidget implements AbstractScreen {
  @override
  final title = "Listas";
  @override
  final icon = Icons.list;
  @override
  final appBarActions = const [];

  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
