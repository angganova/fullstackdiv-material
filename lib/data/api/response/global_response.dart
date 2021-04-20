class GlobalApiResponse {
  String status;
  String message;
  String data;
  String id;

  GlobalApiResponse({this.status, this.message, this.data, this.id});

  GlobalApiResponse.fromJson(Map<String, dynamic> json) {
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
