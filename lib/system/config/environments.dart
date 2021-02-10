import 'package:fullstackdiv_material/system/config/config_service.dart';

class Environments {
  Environments(this._configService);
  final ConfigService _configService;

  String get getCurrentEnv => _configService.getValue('FLUTTER_ENV');
  String get getBaseUrl => _configService.getValue('FULLSTACKDIV_BASE_URL');
  String get getBaseUn => _configService.getValue('FULLSTACKDIV_BASE_UN');
  String get getBasePw => _configService.getValue('FULLSTACKDIV_BASE_PW');
  String get getMapBoxToken => _configService.getValue('MAP_BOX_TOKEN');
}
