class InvalidDataException implements Exception {
  List<String> errors;

  InvalidDataException({required this.errors});
}
