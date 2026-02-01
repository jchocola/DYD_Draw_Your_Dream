import 'package:dyd_drawer/feature/feature_notification/domain/notification_repo.dart';
import 'package:dyd_drawer/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationRepoImpl implements NotificationRepo {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Future<void> init() async {
    try {
      const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('app_icon');
      final DarwinInitializationSettings initializationSettingsDarwin =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );

      final InitializationSettings initializationSettings =
          InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            macOS: initializationSettingsDarwin,
          );

      await flutterLocalNotificationsPlugin.initialize(
        settings: initializationSettings,
      );

      logger.i('LocalNotification plugin initialized');
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    try {
      final DarwinNotificationDetails darwinNotificationDetails =
          DarwinNotificationDetails(
            interruptionLevel: InterruptionLevel.timeSensitive,
        presentSound: true,
        presentList: true,
        presentAlert: true,
        presentBadge: true,
        presentBanner: true,
          );

      final NotificationDetails notificationDetails = NotificationDetails(
        iOS: darwinNotificationDetails,
        macOS: darwinNotificationDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        id: DateTime.now().millisecond,
        title: title,
        body: body,
        notificationDetails: notificationDetails,
      );

      logger.d('Show Notification');
    } catch (e) {
      logger.e(e);
    }
  }
}
