import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/core/presentation/style_constants.dart';
import 'package:proyecto_flutter/profile/presentation/view_model/profile_view_model.dart';

class GeneralSettingsScreen extends StatelessWidget {
  const GeneralSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reader = context.read<ProfileViewModel>();
    final bool isDarkMode =
        context
            .watch<ProfileViewModel>()
            .themeMode == ThemeMode.dark;
    final bool isWideScreen = MediaQuery
        .of(context)
        .size
        .width >= 600;
    final List<DropdownMenuEntry<String>> languages =
    reader.languagesAsDropDownMenuEntries();
    final String selectedLanguage = reader.language;

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajustes/General"),
      ),
      body: Padding(
        padding: isWideScreen ? mediumMargin : compactMargin,
        child: Column(
          children: [
            Card(
              child: ListTile(
                // TODO: usar recurso para el string
                title: Text("Modo oscuro"),
                trailing: Switch(
                    value: isDarkMode,
                    onChanged: (value) {
                      context.read<ProfileViewModel>().toggleTheme(value);
                    }),
              ),
            ),
            Card(
              child: ListTile(
                // TODO: usar recurso para el string
                title: Text("Idioma"),
                trailing: DropdownMenu(
                  initialSelection: selectedLanguage,
                  dropdownMenuEntries: languages,
                  onSelected: (value) {
                    context.read<ProfileViewModel>().changeLanguage(value!);
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                // TODO: usar recurso para el string
                title: Text("Cerrar sesión"),
                onTap: () {
                  // TODO: cerrar sesión.
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
