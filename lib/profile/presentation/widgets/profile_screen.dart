import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.profile),
        actions: [
          IconButton(
            padding: EdgeInsets.all(compactMargin),
            tooltip: AppLocalizations.of(context)!.settings,
            onPressed: () {
              context.pushNamed("settings");
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
