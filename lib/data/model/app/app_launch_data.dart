import 'dart:convert';

class InitialBuildData {
  InitialBuildData({this.launchSource, this.launchPayload});

  InitialBuildData.fromJson(Map<String, dynamic> json) {
    launchSource = json['launchSource'].toString();
    launchPayload = json['launchParameter'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['launchSource'] = launchSource;
    data['launchParameter'] = launchPayload;
    return data;
  }

  String launchSource;
  String launchPayload;

  InitialBuildData fromJsonString(String jsonString) {
    try {
      return InitialBuildData.fromJson(
          jsonDecode(jsonString) as Map<String, dynamic>);
    } catch (e) {
      return InitialBuildData();
    }
  }

  String get jsonString => jsonEncode(toJson());
}
