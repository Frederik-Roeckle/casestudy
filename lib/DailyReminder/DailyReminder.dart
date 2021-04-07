import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class DailyReminder extends StatefulWidget {
  @override
  _DailyReminderState createState() => _DailyReminderState();
}

class _DailyReminderState extends State<DailyReminder> {


  FlutterLocalNotificationsPlugin localNotification;

  @override
  void initState() {
    super.initState();
    var androidInitalize = new AndroidInitializationSettings("splash");
    var iosInitalize = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(android: androidInitalize, iOS: iosInitalize);
    localNotification = new FlutterLocalNotificationsPlugin();
    localNotification.initialize(initializationSettings);
  }

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails("channelId", "Local Notification", "Blaubären essen Blaubeeren", importance: Importance.high);
    var iosDetails = new IOSNotificationDetails();
    var generateNotificationDetails = new NotificationDetails(android: androidDetails, iOS: iosDetails);
    await localNotification.show(0, "Blau", "Esse esse", generateNotificationDetails);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text("Hallo"),
        onPressed: () {
          _showNotification();
        },
      ),
    );
  }
}
