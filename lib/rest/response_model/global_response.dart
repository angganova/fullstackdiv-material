class GlobalResponse {
  String status;
  String message;
  String data;
  String id;

  GlobalResponse({this.status, this.message, this.data, this.id});

  GlobalResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString();
    message = json['message'].toString();
    data = json['data'].toString();
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = data;
    data['id'] = id;
    return data;
  }
}
