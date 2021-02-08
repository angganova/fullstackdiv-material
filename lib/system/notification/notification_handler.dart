import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/app/screens/notification/notification_vm.dart';
import 'package:fullstackdiv_material/model/app/app_launch_data.dart';
import 'package:fullstackdiv_material/model/notification/push_notification_model.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class NotificationHandler {
  NotificationHandler(this.env);
  final Environments env;
  final LoggerBuilder _loggerBuilder = LoggerBuilder('NotificationHandler');

  void handleOnMessageTrigger(PushNotificationData notificationData) {
    /// Trigger app when receive push notification

    if (notificationData?.actionType != null &&
        notificationData?.actionParameter != null) {

    }else{
      printDebug('handleOnMessageTrigger');
      final NotificationVM _notificationVM = getIt<NotificationVM>();
      if(_notificationVM.isWidgetActive){
        _notificationVM.displayPushNotification(notificationData);
      }
    }
  }

  void handleNotificationLaunch(InitialBuildData launchData) {
    /// App launched from notification,
    /// set pending action in the HomeView
    final HomeViewModel homeViewModel = getIt<HomeViewModel>();
    homeViewModel.setPendingInitialAction(launchData);
  }

  Future<void> handleNotificationDirection(
      Map<String, dynamic> jsonPayload) async {
    final PushNotificationData notificationData =
        PushNotificationData.fromJson(jsonPayload);

    if (notificationData?.actionType != null &&
        notificationData?.actionParameter != null) {}
  }

  void printDebug(String print) => _loggerBuilder.printDebug(print);
}
