import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:fullstackdiv_material/app/screens/demo/model/demo_user_model.dart';

/// this is the method to generate [JSON] to [Object]
Future<List<User>> convertUserJson() async {
  return await rootBundle
      .loadString('assets/json/user.json')
      .then((String users) => json.decode(users) as List<dynamic>)
      .then(
    (List<dynamic> value) {
      final List<User> listFlags = <User>[];
      value
          // ignore: avoid_function_literals_in_foreach_calls
          .forEach((dynamic index) => listFlags.add(User.getJsonParser(index)));
      return listFlags;
    },
  );
}
