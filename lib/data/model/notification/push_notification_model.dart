import 'dart:convert';

class PushNotificationData {
  PushNotificationData(
      {this.title, this.body, this.actionType, this.actionParameter});

  factory PushNotificationData.fromMap(Map<dynamic, dynamic> map) {
    if (map == null) {
      return null;
    } else {
      return PushNotificationData(
        title: map['title'] as String,
        body: map['body'] as String,
        actionType: map['actionType'] as String,
        actionParameter: map['actionParameter'] as String,
      );
    }
  }

  PushNotificationData.fromJson(Map<String, dynamic> json) {
    title = json['title'] as String;
    body = json['body'] as String;
    actionType = json['actionType'] as String;
    actionParameter = json['actionParameter'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['actionType'] = actionType;
    data['actionParameter'] = actionParameter;
    return data;
  }

  String title;
  String body;
  String actionType;
  String actionParameter;

  String get notificationDataJson => jsonEncode(toJson());
}
