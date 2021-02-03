/* this is the Demo Model for User */

class User {
  User({
    this.email,
    this.name,
  });

  String email;
  String name;

  /// this method is [required] to convert [User_JSON]
  /// to User [User_Object]
  static User getJsonParser(dynamic json) {
    final String name = json['name'] as String;
    final String email = json['email'] as String;

    return User(email: email, name: name);
  }

  /// this method is [required] to convert [User_Object]
  /// to User [User_JSON]
  Map<String, String> toJson() =>
      <String, String>{'name': name, 'email': email};
}
