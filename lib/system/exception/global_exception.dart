import 'dart:convert';

import 'package:fullstackdiv_material/model/app/global_error.dart';

class GlobalErrorException implements Exception {
  /// This exception will throw GlobalErrorResponse in the message
  /// So make sure to throw GlobalErrorResponse data
  /// And GlobalErrorResponse can be deserialized on the exception handler
  GlobalErrorException(this.message);
  String message;

  GlobalErrorResponse getErrorFromException() {
    try {
      final Map<String, dynamic> data =
          jsonDecode(message) as Map<String, dynamic>;
      final GlobalErrorResponse obj = GlobalErrorResponse.fromJson(data);
      return obj;
    } catch (_) {
      return null;
    }
  }
}

