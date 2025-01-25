import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.lists),
      ),
      body: const Placeholder(),
      floatingActionButton: FloatingActionButton(
        tooltip: AppLocalizations.of(context)!.createList,
        onPressed: () {
          // todo
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
