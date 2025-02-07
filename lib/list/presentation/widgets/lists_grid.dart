import 'package:flutter/material.dart';
import 'package:proyecto_flutter/list/domain/list.dart';
import 'package:proyecto_flutter/list/presentation/widgets/list_card.dart';

import '../../../core/presentation/theme/style_constants.dart';

/// Cuadrícula para mostrar las tarjetas de las listas.
class ListsGrid extends StatelessWidget {
  const ListsGrid({
    super.key,
    required List<FilmsList> lists,
    void Function(FilmsList list)? onListTap,
    void Function(FilmsList list)? onListLongPress,
    EdgeInsetsGeometry? padding,
  })  : _padding = padding,
        _onListLongPress = onListLongPress,
        _onListTap = onListTap,
        _lists = lists;

  final List<FilmsList> _lists;
  final void Function(FilmsList list)? _onListTap;
  final void Function(FilmsList list)? _onListLongPress;
  final EdgeInsetsGeometry? _padding;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: _padding,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 600, // Ancho máximo de cada tarjeta
        childAspectRatio: 3 / 1,
        crossAxisSpacing: 16, // Espacio horizontal entre tarjetas
        mainAxisSpacing: 16, // Espacio vertical entre tarjetas
      ),
      itemCount: _lists.length + 1,
      itemBuilder: (context, index) {
        if (index == _lists.length) return bottomSeparator;
        return ListCard(
          onTap: _onListTap,
          onLongPress: _onListLongPress,
          list: _lists[index],
        );
      },
    );
  }
}
