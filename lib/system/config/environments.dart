import 'package:fullstackdiv_material/system/config/config_service.dart';

class Environments {
  Environments._();

  static Environments instance = Environments._();

  final ConfigService _configService = ConfigService.instance;

  String get getCurrentEnv => _configService.getValue('FLUTTER_ENV');
  String get getBaseUrl => _configService.getValue('BASE_URL');
}
