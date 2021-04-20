class GlobalErrorModel {
  bool error;
  String message;
  String errors;

  GlobalErrorModel({this.error, this.message, this.errors});

  GlobalErrorModel.fromJson(Map<String, dynamic> json) {
    error = json['error'] as bool;
    message = json['message']as String;
    errors = json['errors']as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    data['message'] = message;
    data['errors'] = errors;
    return data;
  }
}
