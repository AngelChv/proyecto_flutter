import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_flutter/list/presentation/view_model/list_view_model.dart';
import 'package:proyecto_flutter/list/presentation/widgets/lists_grid.dart';

import '../../../core/presentation/theme/style_constants.dart';
import '../../domain/list.dart';

/// Pantalla para mostrar las listas.
///
/// **En desarrollo.**
class ListsScreen extends StatelessWidget {
  const ListsScreen({super.key});

  ListsGrid _listsGrid(
      BuildContext context, bool isWideScreen, List<FilmsList> lists) {
    return ListsGrid(
      padding: EdgeInsets.all(isWideScreen ? mediumMargin : compactMargin),
      onListTap: (list) {
        context.read<ListViewModel>().selectList(list);
        context.pushNamed<FilmsList>("listDetails", extra: list);
      },
      lists: lists,
    );
  }

  Center _loading() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.sizeOf(context).width >= 600;
    final lists = context.watch<ListViewModel>().getLists();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.lists),
      ),
      body:
          lists == null ? _loading() : _listsGrid(context, isWideScreen, lists),
      floatingActionButton: FloatingActionButton(
        heroTag: "listsScreenFab",
        tooltip: AppLocalizations.of(context)!.createList,
        onPressed: () async {
          final String? message = await context.pushNamed<String>("listForm");

          if (context.mounted && message != null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(message),
            ));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
