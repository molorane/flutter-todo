import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todo_api/todo_api.dart';

import '../util/task.type.util.dart';

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

  Future<void> showBasicNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10, channelKey: 'basic_channel', title: title, body: body),
        actionButtons: [NotificationActionButton(key: "Okay", label: "Okay")]);
  }

  Future<void> showBasicNotificationWithBigPicture(
      {int id = 0,
      required TaskType taskType,
      String? title,
      String? body,
      String? payLoad}) async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: title,
            body: body,
            bigPicture:
                'asset://${TaskTypeUtil.getTaskImageFromTaskType(taskType)}',
            notificationLayout: NotificationLayout.BigPicture),
        actionButtons: [NotificationActionButton(key: "Okay", label: "Okay")]);
  }
}
