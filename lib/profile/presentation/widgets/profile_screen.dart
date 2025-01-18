import 'package:flutter/material.dart';
import 'package:proyecto_flutter/core/presentation/style_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        actions: [
          Padding(
            padding: compactMargin,
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
