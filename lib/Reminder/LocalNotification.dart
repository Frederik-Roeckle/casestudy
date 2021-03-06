import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {

  FlutterLocalNotificationsPlugin localNotification;

  LocalNotification() {
    var androidInitalize = new AndroidInitializationSettings("splash");
    var iosInitalize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: androidInitalize, iOS: iosInitalize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings, onSelectNotification: _notificationSelected);
  }

  Future _notificationSelected(String payload) async {
    print("Notification Callback");
  }

  Future showNotification(String messageHeader, String messageBody) async {
    var androidDetails = new AndroidNotificationDetails("channelId", "Local Notification", "a", importance: Importance.max, priority: Priority.high, fullScreenIntent: true);
    var iosDetails = new IOSNotificationDetails();
    var generateNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(0, messageHeader, messageBody, generateNotificationDetails, payload: "Baumhaus");
  }

}