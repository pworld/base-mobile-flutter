class HTTPRequestException implements Exception {
  final String message;
  final dynamic rawData;

  const HTTPRequestException({
    required this.message,
    required this.rawData,
  });
}
