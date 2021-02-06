import 'package:fullstackdiv_material/system/config/config_service.dart';

class Environments {
  Environments(this._configService);
  final ConfigService _configService;

  String get getCurrentEnv => _configService.getValue('FLUTTER_ENV');

  String get getBaseUrl => _configService.getValue('FULLSTACKDIV_BASE_URL');
}
