// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:fullstackdiv_material/system/copy/copy.dart';
import 'package:fullstackdiv_material/system/copy/copy_module.dart';
import 'package:fullstackdiv_material/app/screens/demo/screens/map/demo_map_vm.dart';
import 'package:fullstackdiv_material/system/deeplink/deeplink_service.dart';
import 'package:fullstackdiv_material/system/notification/fcm_notification_setting.dart';
import 'package:fullstackdiv_material/app/components/map/view_model/geofence_vm.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/app/components/map/view_model/location_vm.dart';
import 'package:fullstackdiv_material/app/screens/notification/notification_vm.dart';
import 'package:fullstackdiv_material/app/components/map/zmap_vm.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final copyModule = _$CopyModule();
  final resolvedCopy = await copyModule.copy;
  gh.factory<Copy>(() => resolvedCopy);
  gh.factory<DemoMapViewModel>(() => DemoMapViewModel());
  gh.factory<DynamicLinkService>(() => DynamicLinkService());
  gh.lazySingleton<GeofenceViewModel>(() => GeofenceViewModel());
  gh.lazySingleton<HomeViewModel>(
      () => HomeViewModel(get<Copy>(), get<FCMNotificationSetting>()));
  gh.lazySingleton<LocationViewModel>(() => LocationViewModel());
  gh.lazySingleton<NotificationVM>(
      () => NotificationVM(get<FCMNotificationSetting>()));
  gh.factory<ZMapViewModel>(() => ZMapViewModel());
  return get;
}

class _$CopyModule extends CopyModule {}
