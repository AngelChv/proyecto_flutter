import 'package:flutter/material.dart';

/// Tarjeta responsiva que contiene un LisTile o un column con un DropDownMenu
///
/// Si la pantalla es ancha se usa un ListTile.
/// Si la pantalla es compacta se usa un Column.
/// Esto evita que el DropdownButton se superponga al texto en la vista compacta
/// al estar en vertical en lugar de horizontal.
class SelectionMenuItem extends StatelessWidget {
  const SelectionMenuItem({
    super.key,
    required Widget title,
    required String selectedLanguage,
    required List<DropdownMenuEntry<String>> languages,
    required dynamic Function(String) onSelected,
  })  : _onSelected = onSelected,
        _languages = languages,
        _selectedLanguage = selectedLanguage,
        _title = title;

  final Widget _title;
  final String _selectedLanguage;
  final List<DropdownMenuEntry<String>> _languages;
  final Function(String key) _onSelected;

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    return isWideScreen
        ? Card(
            child: ListTile(
              title: _title,
              trailing: DropdownMenu(
                initialSelection: _selectedLanguage,
                dropdownMenuEntries: _languages,
                onSelected: (value) {
                  _onSelected(value!);
                },
              ),
            ),
          )
        : Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  spacing: 8,
                  children: [
                    _title,
                    DropdownMenu(
                      initialSelection: _selectedLanguage,
                      dropdownMenuEntries: _languages,
                      onSelected: (value) {
                        _onSelected(value!);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}