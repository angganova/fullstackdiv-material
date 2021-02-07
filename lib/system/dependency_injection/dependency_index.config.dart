// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:fullstackdiv_material/system/copy/copy.dart';
import 'package:fullstackdiv_material/system/copy/copy_module.dart';
import 'package:fullstackdiv_material/rest/client/default_api_client.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/notification/fcm_notification_setting.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/system/notification/local_notification_setting.dart';
import 'package:fullstackdiv_material/system/notification/local_notification_show.dart';
import 'package:fullstackdiv_material/system/notification/notification_handler.dart';
import 'package:fullstackdiv_material/rest/client/global_repository.dart';

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
  gh.lazySingleton<DefaultApiClient>(
      () => DefaultApiClient(get<Environments>()));
  gh.lazySingleton<NotificationHandler>(
      () => NotificationHandler(get<Environments>()));
  gh.lazySingleton<RestRepo>(() => RestRepo(get<DefaultApiClient>()));
  gh.lazySingleton<LocalNotificationSetting>(() => LocalNotificationSetting(
      get<Environments>(), get<NotificationHandler>()));
  gh.lazySingleton<LocalNotificationShow>(() => LocalNotificationShow(
      get<LocalNotificationSetting>(), get<Environments>()));
  gh.lazySingleton<FCMNotificationSetting>(() => FCMNotificationSetting(
      get<NotificationHandler>(), get<LocalNotificationShow>()));
  gh.lazySingleton<HomeViewModel>(
      () => HomeViewModel(get<Copy>(), get<FCMNotificationSetting>()));
  return get;
}

class _$CopyModule extends CopyModule {}
