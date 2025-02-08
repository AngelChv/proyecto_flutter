import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/theme/style_constants.dart';
import 'package:proyecto_flutter/core/presentation/widgets/selection_menu_item.dart';
import 'package:proyecto_flutter/profile/presentation/view_model/profile_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Pantalla de la configuración general
class GeneralSettingsScreen extends StatelessWidget {
  const GeneralSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;

    final profileVM = context.watch<ProfileViewModel>();
    final bool isDarkMode = profileVM.themeMode == ThemeMode.dark;
    final List<DropdownMenuEntry<String>> languages =
        profileVM.languagesAsDropDownMenuEntries();
    final String selectedLanguage = profileVM.language;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.generalSettings),
      ),
      body: Padding(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        child: Column(
          // TODO: hacerlo mas responsive para que no ocupe toda la pantalla
          children: [
            Card(
              child: ListTile(
                title: Text(AppLocalizations.of(context)!.darkMode),
                trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      context.read<ProfileViewModel>().toggleTheme(value);
                    }),
              ),
            ),
            SelectionMenuItem(
              title: Text(
                AppLocalizations.of(context)!.language,
                // TODO: parece que no funciona en modo compacto.
                style: Theme.of(context).listTileTheme.titleTextStyle,
              ),
              selectedLanguage: selectedLanguage,
              languages: languages,
              onSelected: (value) {
                context.read<ProfileViewModel>().changeLanguage(value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
