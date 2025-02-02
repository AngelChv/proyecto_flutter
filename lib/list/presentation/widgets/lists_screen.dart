import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/list/presentation/widgets/lists_grid.dart';

import '../../../core/presentation/theme/style_constants.dart';

/// Pantalla para mostrar las listas.
///
/// **En desarrollo.**
class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    final lists = context.watch<ListViewModel>().lists;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.lists),
      ),
      body: ListsGrid(
        padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
        onListTap: (film) {
          // TODO: tap
        },
        onListLongPress: (film) {
          // TODO: long press
        },
        lists: lists,
      ),
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
