import 'package:fullstackdiv_material/system/config/config_service.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/config/platform_info.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataModule {
  @preResolve
  @singleton
  Future<PlatformInfo> get platformInfo => PlatformInfoImpl.getInstance();

  @preResolve
  @singleton
  Future<ConfigService> get config => ConfigService.getInstance();

  @preResolve
  @singleton
  Environments getEnvironments(ConfigService config) => Environments(config);
}
