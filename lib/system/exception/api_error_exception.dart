class ApiErrorException implements Exception {
  /// This exception will throw GlobalErrorResponse in the message
  /// So make sure to throw GlobalErrorResponse data
  /// And GlobalErrorResponse can be deserialized on the exception handler
  ApiErrorException(this.type, this.message);

  final ApiErrorType type;
  final String message;
}

enum ApiErrorType {
  General,
  Unknown,
}
