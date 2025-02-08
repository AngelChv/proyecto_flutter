import 'package:proyecto_flutter/list/domain/list_result.dart';
import 'package:sqflite/sqflite.dart';

/// Resultado de una petición a sqlite.
///
/// Extiende de [ListResult] y contiene el resultado de la petición junto con
/// una posible excepción.
class ListSqliteResult<R> extends ListResult<R> {
  final R _result;

  final DatabaseException? _e;

  ListSqliteResult(this._result, this._e);


  @override
  R get result => _result;

  @override
  DatabaseException? get e => _e;
}
