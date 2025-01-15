import 'package:flutter/material.dart';
import 'package:proyecto_flutter/ui/screens/abstract_screen.dart';

class ProfileScreen extends StatelessWidget implements AbstractScreen {
  @override
  final title = "Perfil";
  @override
  final icon = Icons.person;
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
