import 'package:flutter/material.dart';
import 'package:proyecto_flutter/list/domain/list.dart';

/// Tarjeta que muestra la información de una lista.
class ListCard extends StatelessWidget {
  const ListCard({super.key,
    void Function(FilmsList)? onTap,
    void Function(FilmsList)? onLongPress, required FilmsList list})
      : _list = list,
        _onLongPress = onLongPress,
        _onTap = onTap;

  final void Function(FilmsList list)? _onTap;
  final void Function(FilmsList list)? _onLongPress;
  final FilmsList _list;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_onTap != null) {
          _onTap(_list);
        }
      },
      onLongPress: () {
        if (_onLongPress != null) {
          _onLongPress(_list);
        }
      },
      child: Card(
        child: Center(child: ListInfo(list: _list)),
      ),
    );
  }
}

/// Muestra de manera visual la información de una lista.
///
/// De momento solo muestra el nombre.
class ListInfo extends StatelessWidget {
  const ListInfo({super.key, required FilmsList list}) : _list = list;

  final FilmsList _list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(_list.name, style: Theme.of(context).textTheme.headlineSmall,),
    );
  }
}
