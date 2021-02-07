class CopyItem {
  CopyItem(this.id, this.en);

  factory CopyItem.fromJson(Map<String, dynamic> json) =>
      CopyItem(json['id'] as String, json['en'] as String);
  String id;
  String en;
}
