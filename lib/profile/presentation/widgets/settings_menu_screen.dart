import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_flutter/core/domain/app_routes.dart';
import 'package:proyecto_flutter/core/presentation/style_constants.dart';

class SettingsMenuScreen extends StatelessWidget {
  const SettingsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes"),
      ),
      body: Padding(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        child: Column(
          children: [
            Card(
              child: ListTile(
                // TODO: usar recurso para el string
                leading: Icon(Icons.edit),
                title: Text("General"),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  GoRouter.of(context).go(AppRoutes.generalSettings);
                },
              ),
            ),
            Card(
              child: ListTile(
                // TODO: usar recurso para el string
                leading: Icon(Icons.person),
                title: Text("Perfil"),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  GoRouter.of(context).go(AppRoutes.userSettings);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
