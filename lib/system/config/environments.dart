import 'package:fullstackdiv_material/system/config/config_service.dart';
import 'package:injectable/injectable.dart';

class Environments {
  Environments(this._configService);
  final ConfigService _configService;

  String get getCurrentEnv => _configService.getValue('FLUTTER_ENV');
  String get getBaseUrl => _configService.getValue('FULLSTACKDIV_BASE_URL');
  String get getBaseUn => _configService.getValue('FULLSTACKDIV_BASE_UN');
  String get getBasePw => _configService.getValue('FULLSTACKDIV_BASE_PW');
  String get getMixpanelToken => _configService.getValue('APP_MIXPANEL_TOKEN');
}
