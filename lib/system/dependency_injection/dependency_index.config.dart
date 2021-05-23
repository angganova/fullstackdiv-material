// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:fullstackdiv_material/app/components/map/view_model/geofence_vm.dart'
    as _i6;
import 'package:fullstackdiv_material/app/components/map/view_model/location_vm.dart'
    as _i8;
import 'package:fullstackdiv_material/app/components/map/zmap_vm.dart' as _i11;
import 'package:fullstackdiv_material/app/screens/demo/screens/map/demo_map_vm.dart'
    as _i4;
import 'package:fullstackdiv_material/app/screens/home/home_vm.dart' as _i7;
import 'package:fullstackdiv_material/app/screens/notification/notification_vm.dart'
    as _i9;
import 'package:fullstackdiv_material/system/copy/copy.dart' as _i3;
import 'package:fullstackdiv_material/system/copy/copy_module.dart' as _i12;
import 'package:fullstackdiv_material/system/deeplink/deeplink_service.dart'
    as _i5;
import 'package:fullstackdiv_material/system/notification/fcm_notification_setting.dart'
    as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart'
    as _i2; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final copyModule = _$CopyModule();
  await gh.factoryAsync<_i3.Copy>(() => copyModule.copy, preResolve: true);
  gh.factory<_i4.DemoMapViewModel>(() => _i4.DemoMapViewModel());
  gh.factory<_i5.DynamicLinkService>(() => _i5.DynamicLinkService());
  gh.lazySingleton<_i6.GeofenceViewModel>(() => _i6.GeofenceViewModel());
  gh.lazySingleton<_i7.HomeViewModel>(() => _i7.HomeViewModel());
  gh.lazySingleton<_i8.LocationViewModel>(() => _i8.LocationViewModel());
  gh.lazySingleton<_i9.NotificationVM>(
      () => _i9.NotificationVM(get<_i10.FCMNotificationSetting>()));
  gh.factory<_i11.ZMapViewModel>(() => _i11.ZMapViewModel());
  return get;
}

class _$CopyModule extends _i12.CopyModule {}
