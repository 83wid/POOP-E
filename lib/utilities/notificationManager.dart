import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationManager {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationManager() {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    initNotifications();
  }

  FlutterLocalNotificationsPlugin getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  Future configureLocalTime(dateTime) async {
    tz.initializeTimeZones();
    return tz.TZDateTime.from(dateTime, tz.getLocation('Africa/Casablanca'));
  }

  void initNotifications() {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void showNotificationDaily(
      int id, String? title, String? body, int hour, int minute) async {
    var dateTime = new DateTime(DateTime.now().year, DateTime.now().month,
        DateTime.now().day, hour, minute, 0);

    // The device's timezone.

    final tz.TZDateTime scheduledDate = await configureLocalTime(dateTime);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
     scheduledDate,
      getPlatformChannelSpecfics(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
    // await flutterLocalNotificationsPlugin.showDailyAtTime(
    //     id, title, body, time, getPlatformChannelSpecfics());
    print(
        'Notification Succesfully Scheduled at ${dateTime.hour.toString() + ': ' + dateTime.minute.toString()}');
  }

  getPlatformChannelSpecfics() {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'Medicine Reminder');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    return platformChannelSpecifics;
  }

  Future<dynamic> onSelectNotification(String? payload) async {
    print('Hello it\'s pressed');
    return Future.value(1);
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    return Future.value(1);
  }

  void removeReminder(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  Future<void> scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      DateTime? scheduledTime}) async {
    var androidSpecifics = AndroidNotificationDetails(
      'channel-id', // This specifies the ID of the Notification
      'Scheduled notification', // This specifies the name of the notification channel
      'A scheduled notification', //This specifies the description of the channel
      icon: 'icon',
    );
    // var iOSSpecifics = notifs.IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidSpecifics,
      //  iOS: iOSSpecifics
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduledTime != null ? scheduledTime : DateTime.now(),
        tz.local,
      ),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    ); // This literally schedules the notification
  }
}
