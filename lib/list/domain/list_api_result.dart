import 'package:proyecto_flutter/core/domain/http_status_exception.dart';
import 'package:proyecto_flutter/list/domain/list_result.dart';

/// Resultado de una petición a sqlite.
///
/// Extiende de [ListResult] y contiene el resultado de la petición junto con
/// una posible excepción.
class ListApiResult<R> extends ListResult<R> {
  final R _result;

  final HttpStatusException? _e;

  ListApiResult(this._result, this._e);


  @override
  R get result => _result;

  @override
  HttpStatusException? get e => _e;
}
