import 'dart:convert';

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

class GlobalErrorResponse {
  String status;
  String message;
  int code;
  GlobalErrorResponseData data;

  GlobalErrorResponse({this.status, this.message, this.code, this.data});

  GlobalErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    code = json['code'];
    data = json['data'] != null
        ? new GlobalErrorResponseData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class GlobalErrorResponseData {
  String message;
  int errorCode;

  GlobalErrorResponseData({this.message, this.errorCode});

  GlobalErrorResponseData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errorCode = json['error_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error_code'] = this.errorCode;
    return data;
  }
}
