import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/theme/style_constants.dart';
import '../../../login/presentation/view_model/user_view_model.dart';

/// Pantalla de configuración del perfil de usuario.
///
/// Permite cerrar la sesión.
class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profileSettings),
      ),
      body: Padding(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        child: Column(
          // TODO: hacerlo mas responsive para que no ocupe toda la pantalla
          children: [
            Card(
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.logout),
                onTap: () {
                  context.read<UserViewModel>().logout();
                  context.goNamed("login");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
