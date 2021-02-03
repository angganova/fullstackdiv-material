class ConnectionErrorException implements Exception {
  /// This exception will throw GlobalErrorResponse in the message
  /// So make sure to throw GlobalErrorResponse data
  /// And GlobalErrorResponse can be deserialized on the exception handler
  ConnectionErrorException(this.type, this.message);

  final ConnectionErrorType type;
  final String message;
}

enum ConnectionErrorType {
  Timeout,
  Cancel,
  Default,
}
