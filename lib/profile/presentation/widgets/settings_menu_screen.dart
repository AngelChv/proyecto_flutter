import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Pantalla que muestra el menú de la configuración.
class SettingsMenuScreen extends StatelessWidget {
  const SettingsMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        child: Column(
          children: [
            Card(
              child: ListTile(
                // TODO: usar recurso para el string
                leading: Icon(Icons.edit),
                title: Text(AppLocalizations.of(context)!.general),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  context.pushNamed("generalSettings");
                },
              ),
            ),
            Card(
              child: ListTile(
                // TODO: usar recurso para el string
                leading: Icon(Icons.person),
                title: Text(AppLocalizations.of(context)!.profile),
                trailing: Icon(Icons.arrow_right),
                onTap: () {
                  context.pushNamed("userSettings");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
