import 'package:fullstackdiv_material/data/api/response/global_response.dart';

class ApiGlobalException implements Exception {
  /// This exception will throw GlobalErrorResponse in the message
  /// So make sure to throw GlobalErrorResponse data
  /// And GlobalErrorResponse can be deserialized on the exception handler
  ApiGlobalException(this.type, this.globalResponse);

  final ApiErrorType type;
  final GlobalResponse globalResponse;
}

enum ApiErrorType {
  General,
  Unknown,
}
