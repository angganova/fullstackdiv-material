import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environments {
  Environments() {
    init();
  }

  Future<void> init() async {
    await DotEnv().load();
  }

  String get currentEnv => getValue('FLUTTER_ENV');

  String getValue(String key) {
    if (DotEnv().env.containsKey(key)) {
      return DotEnv().env[key];
    } else {
      return '';
    }
  }
}
