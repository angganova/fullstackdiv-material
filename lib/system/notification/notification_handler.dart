// import 'dart:convert';
//
// import 'package:injectable/injectable.dart';
// import 'package:zest/app/screens/home/home_vm.dart';
// import 'package:zest/app/screens/taxi/taxi_mini_view/taxi_mini_vm.dart';
// import 'package:zest/app/screens/taxi/taxi_view/taxi_vm.dart';
// import 'package:zest/config/environments.dart';
// import 'package:zest/data/domain/taxi/booking_status_message.dart';
// import 'package:zest/data/model/notification/push_notification_model.dart';
// import 'package:zest/data/model/zest/app_launch_data_model.dart';
// import 'package:zest/system/di/index.dart';
// import 'package:zest/system/utils/constants.dart';
// import 'package:zest/system/utils/debugger/logger_builder.dart';
// import 'package:zest/system/utils/notification/notification_constant.dart';
//
// @lazySingleton
// class NotificationHandler {
//   NotificationHandler(this.env);
//   final Environments env;
//   final LoggerBuilder _loggerBuilder = LoggerBuilder('NotificationHandler');
//
//   void handleOnMessageTrigger(PushNotificationData notificationData) {
//     if (notificationData?.actionType != null &&
//         notificationData?.actionParameter != null) {
//       switch (notificationData.actionType.toLowerCase()) {
//         case NotificationConstant.notificationActionTypeTaxiBookingUpdate:
//           {
//             _handleTaxiBookingNUpdateNotification(notificationData);
//             break;
//           }
//         default:
//           break;
//       }
//     }
//   }
//
//   void handleNotificationLaunch(InitialBuildData launchData) {
//     /// App launched from notification,
//     /// set pending action in the HomeView
//     final HomeViewModel homeViewModel = getIt<HomeViewModel>();
//     homeViewModel.setPendingInitialAction(launchData);
//   }
//
//   Future<void> handleNotificationDirection(
//       Map<String, dynamic> jsonPayload) async {
//     final PushNotificationData notificationData =
//         PushNotificationData.fromJson(jsonPayload);
//
//     if (notificationData?.actionType != null &&
//         notificationData?.actionParameter != null) {
//       switch (notificationData.actionType.toLowerCase()) {
//         case NotificationConstant.notificationActionTypeTaxiBookingUpdate:
//           {
//             _navigateToTaxiView(notificationData);
//             break;
//           }
//         case NotificationConstant.notificationActionTypeMarketplace:
//           {
//             _navigateToMarketPlaceView(notificationData);
//             break;
//           }
//         default:
//           break;
//       }
//     }
//   }
//
//   void _handleTaxiBookingNUpdateNotification(
//       PushNotificationData notificationData) {
//     try {
//       final SocketBookingStatusMessage socketBookingStatusMessage =
//           SocketBookingStatusMessage.fromJson(
//               jsonDecode(notificationData.actionParameter)
//                   as Map<String, dynamic>);
//
//       final TaxiViewModel taxiViewModel = getIt<TaxiViewModel>();
//       taxiViewModel?.vmUiHandler
//           ?.handleBookingStatusMessage(socketBookingStatusMessage);
//
//       final TaxiMiniViewModel taxiMiniViewModel = getIt<TaxiMiniViewModel>();
//       taxiMiniViewModel?.handleBookingStatusMessage(socketBookingStatusMessage);
//     } catch (e) {
//       printDebug(e.toString());
//     }
//   }
//
//   void _navigateToTaxiView(PushNotificationData pushNotificationData) {
//     final bool isLoggedIn = env.getUserJWT != null;
//     try {
//       final SocketBookingStatusMessage socketBookingStatusMessage =
//           SocketBookingStatusMessage.fromJson(
//               jsonDecode(pushNotificationData.actionParameter)
//                   as Map<String, dynamic>);
//       if (isLoggedIn) {
//         final HomeViewModel homeViewModel = getIt<HomeViewModel>();
//         homeViewModel.launchTaxiWithJobNo(socketBookingStatusMessage.jobno);
//       } else {
//         handleNotificationLaunch(InitialBuildData(
//             launchSource: appLaunchNotificationSourceID,
//             launchPayload: pushNotificationData.actionParameter));
//       }
//     } catch (e) {
//       printDebug('_navigateToTaxiView error $e');
//     }
//   }
//
//   Future<void> _navigateToMarketPlaceView(
//       PushNotificationData pushNotificationData) async {
//     final bool isLoggedIn = env.getUserJWT != null;
//     try {
//       if (isLoggedIn) {
//         final HomeViewModel homeViewModel = getIt<HomeViewModel>();
//         homeViewModel
//             .launchMarketPlaceWithId(pushNotificationData.actionParameter);
//       } else {
//         handleNotificationLaunch(InitialBuildData(
//             launchSource: appLaunchNotificationSourceID,
//             launchPayload: pushNotificationData.actionParameter));
//       }
//     } catch (e) {
//       printDebug('_navigateToMarketPlaceView error $e');
//     }
//   }
//
//   void printDebug(String print) => _loggerBuilder.printDebug(print);
// }
