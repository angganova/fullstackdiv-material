import 'package:fullstackdiv_material/app/screens/home/home_vm.dart';
import 'package:fullstackdiv_material/data/model/app/app_launch_data.dart';
import 'package:fullstackdiv_material/data/model/notification/push_notification_model.dart';
import 'package:fullstackdiv_material/system/config/environments.dart';
import 'package:fullstackdiv_material/system/debugger/logger_builder.dart';
import 'package:fullstackdiv_material/system/dependency_injection/dependency_index.dart';

class NotificationHandler {
  NotificationHandler._();
  final Environments env = Environments.instance;
  final LoggerBuilder _loggerBuilder = LoggerBuilder('NotificationHandler');

  static NotificationHandler instance = NotificationHandler._();

  void handleOnMessageTrigger(PushNotificationData notificationData) {
    /// Trigger app when receive push notification

    if (notificationData?.actionType != null &&
        notificationData?.actionParameter != null) {
    } else {}
  }

  void handleNotificationLaunch(InitialBuildData launchData) {
    /// App launched from notification,
    /// set pending action in the HomeView
    final HomeViewModel mainVm = getIt<HomeViewModel>();
    mainVm.setPendingInitialAction(launchData);
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
