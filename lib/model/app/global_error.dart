class GlobalErrorResponse {
  String status;
  String message;
  int code;
  GlobalErrorResponseData data;

  GlobalErrorResponse({this.status, this.message, this.code, this.data});

  GlobalErrorResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    code = json['code'] as int;
    data = json['data'] != null
        ? GlobalErrorResponseData.fromJson(json['data'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['code'] = code;
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
    message = json['message'] as String;
    errorCode = json['error_code'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['error_code'] = errorCode;
    return data;
  }
}
