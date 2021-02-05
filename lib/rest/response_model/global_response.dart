
class GlobalResponse {
  String status;
  String message;
  String data;
  String id;

  GlobalResponse({this.status, this.message, this.data, this.id});

  GlobalResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    data['id'] = this.id;
    return data;
  }
}