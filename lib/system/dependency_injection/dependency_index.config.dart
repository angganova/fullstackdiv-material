// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:fullstackdiv_material/data/api/client/api_client.dart';
import 'package:fullstackdiv_material/data/api/client/api_repository.dart';
import 'package:fullstackdiv_material/system/config/config_service.dart';
import 'package:fullstackdiv_material/system/copy/copy.dart';
import 'package:fullstackdiv_material/system/copy/copy_module.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_premodule.dart';
import 'package:fullstackdiv_material/app/screens/demo/screens/map/demo_map_vm.dart';
import 'package:fullstackdiv_material/system/deeplink/deeplink_service.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/notification/fcm_notification_setting.dart';
import 'package:fullstackdiv_material/app/components/map/view_model/geofence_vm.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/system/notification/local_notification_setting.dart';
import 'package:fullstackdiv_material/system/notification/local_notification_show.dart';
import 'package:fullstackdiv_material/app/components/map/view_model/location_vm.dart';
import 'package:fullstackdiv_material/system/notification/notification_handler.dart';
import 'package:fullstackdiv_material/app/screens/notification/notification_vm.dart';
import 'package:fullstackdiv_material/system/config/platform_info.dart';
import 'package:fullstackdiv_material/app/components/map/zmap_vm.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final dataModule = _$DataModule();
  final copyModule = _$CopyModule();
  final resolvedCopy = await copyModule.copy;
  gh.factory<Copy>(() => resolvedCopy);
  gh.factory<DemoMapViewModel>(() => DemoMapViewModel());
  gh.factory<DynamicLinkService>(() => DynamicLinkService());
  gh.lazySingleton<GeofenceViewModel>(() => GeofenceViewModel());
  gh.lazySingleton<LocationViewModel>(() => LocationViewModel());
  gh.lazySingleton<NotificationHandler>(
      () => NotificationHandler(get<Environments>()));
  gh.factory<ZMapViewModel>(() => ZMapViewModel());
  gh.lazySingleton<ApiClient>(() => ApiClient(get<Environments>()));
  gh.lazySingleton<ApiRepository>(() => ApiRepository(get<ApiClient>()));
  gh.lazySingleton<LocalNotificationSetting>(() => LocalNotificationSetting(
      get<Environments>(), get<NotificationHandler>()));
  gh.lazySingleton<LocalNotificationShow>(() => LocalNotificationShow(
      get<LocalNotificationSetting>(), get<Environments>()));
  gh.lazySingleton<FCMNotificationSetting>(() => FCMNotificationSetting(
      get<NotificationHandler>(), get<LocalNotificationShow>()));
  gh.lazySingleton<HomeViewModel>(
      () => HomeViewModel(get<Copy>(), get<FCMNotificationSetting>()));
  gh.lazySingleton<NotificationVM>(
      () => NotificationVM(get<FCMNotificationSetting>()));

  // Eager singletons must be registered in the right order
  final resolvedConfigService = await dataModule.config;
  gh.singleton<ConfigService>(resolvedConfigService);
  gh.singleton<Environments>(dataModule.getEnvironments(get<ConfigService>()));
  final resolvedPlatformInfo = await dataModule.platformInfo;
  gh.singleton<PlatformInfo>(resolvedPlatformInfo);
  return get;
}

class _$DataModule extends DataModule {}

class _$CopyModule extends CopyModule {}
