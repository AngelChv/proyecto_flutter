import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_flutter/core/presentation/style_constants.dart';

import '../../../core/domain/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        actions: [
          IconButton(
            padding: EdgeInsets.all(compactMargin),
            tooltip: "Ajustes",
            onPressed: () {
              GoRouter.of(context).go(AppRoutes.settingsMenu);
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
