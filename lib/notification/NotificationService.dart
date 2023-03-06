import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  Future<void> initNotification() async {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'basic_channel',
              channelName: 'Basic notification',
              channelDescription: 'Notification channel for testing',
              importance: NotificationImportance.High)
        ],
        debug: true);
  }

  Future<void> requestPermission() {
    return AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  Future showBasicNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10, channelKey: 'basic_channel', title: title, body: body));
  }
}
