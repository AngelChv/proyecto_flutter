class HttpStatusException implements Exception {
  final int statusCode;

  HttpStatusException(this.statusCode);
}
