import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('app_icon');

    var iosInitSettings = DarwinInitializationSettings();

    var initSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitSettings);

    await notificationsPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      print(response);
    }, onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}
