/// Representa el resultado devuelto por una petición, tanto a una api como sqlite.
abstract class ListResult<T> {
  T get result;
  Exception? get e;
}