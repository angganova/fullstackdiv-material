import 'package:fullstackdiv_material/system/analytics/default_analytics.dart';
import 'package:fullstackdiv_material/system/analytics/mixpanel_analytics.dart';
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
  Future<ConfigService> get config => ConfigServiceImpl.getInstance();

  @preResolve
  @singleton
  Environments getEnvironments(ConfigService config) => Environments(config);

  @preResolve
  @singleton
  Future<MixpanelAnalytics> getMixPanel(PlatformInfo info, Environments env) =>
      MixpanelAnalytics.getInstance(info, env);

  @preResolve
  @singleton
  Future<DefaultAnalytics> getTaxiAnalytics(MixpanelAnalytics analytics) =>
      DefaultAnalytics.getInstance(analytics);
}
