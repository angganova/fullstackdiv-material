// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_vm.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationVM on _NotificationVM, Store {
  final _$notificationDataAtom = Atom(name: '_NotificationVM.notificationData');

  @override
  PushNotificationData get notificationData {
    _$notificationDataAtom.reportRead();
    return super.notificationData;
  }

  @override
  set notificationData(PushNotificationData value) {
    _$notificationDataAtom.reportWrite(value, super.notificationData, () {
      super.notificationData = value;
    });
  }

  final _$restSendFcmTokenRequestingAtom =
      Atom(name: '_NotificationVM.restSendFcmTokenRequesting');

  @override
  bool get restSendFcmTokenRequesting {
    _$restSendFcmTokenRequestingAtom.reportRead();
    return super.restSendFcmTokenRequesting;
  }

  @override
  set restSendFcmTokenRequesting(bool value) {
    _$restSendFcmTokenRequestingAtom
        .reportWrite(value, super.restSendFcmTokenRequesting, () {
      super.restSendFcmTokenRequesting = value;
    });
  }

  final _$deviceFCMTokenAtom = Atom(name: '_NotificationVM.deviceFCMToken');

  @override
  String get deviceFCMToken {
    _$deviceFCMTokenAtom.reportRead();
    return super.deviceFCMToken;
  }

  @override
  set deviceFCMToken(String value) {
    _$deviceFCMTokenAtom.reportWrite(value, super.deviceFCMToken, () {
      super.deviceFCMToken = value;
    });
  }

  @override
  String toString() {
    return '''
notificationData: ${notificationData},
restSendFcmTokenRequesting: ${restSendFcmTokenRequesting},
deviceFCMToken: ${deviceFCMToken}
    ''';
  }
}
