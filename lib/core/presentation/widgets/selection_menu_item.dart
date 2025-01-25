import 'package:flutter/material.dart';

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
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isWideScreen = MediaQuery.of(context).size.width >= 600;

        if (isWideScreen) {
          return Card(
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
          );
        } else {
          return Card(
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
      },
    );
  }
}
