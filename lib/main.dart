import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/DailyReminder/LocalNotification.dart';
import 'package:flutter_app_casestudy/Lockscreen/Lockscreen.dart';
import 'package:flutter_app_casestudy/Physiotherapie.dart';
import 'package:flutter_app_casestudy/Tagebuch.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodPoll.dart';
import 'package:path/path.dart';
import 'package:workmanager/workmanager.dart';
import 'homescreen.dart';
import 'Kalender.dart';


void main() {
  initWorkManager();
  return runApp(AppLock(
      builder: (args) => MaterialApp(
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          routes: {
            // When navigating to the "/" route, build the HomeScreen Widget
            '/': (context) => HomescreenList(),
            // Other Routes
            '/Kalender': (context) => Kalender(),
            '/Physiotherapie': (context) => Physiotherapie(),
            '/Tagebuch': (context) => Tagebuch(),
             '/MoodPoll': (context) => MoodPoll(),
          },
      ),
      lockScreen: Lockscreen()
    )
  );
}

//Callback Funktion die vom Workmanager aufgerufen wird
void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) {
    //print("Native called background task at ${DateTime.now().toString()}");     //Eine Art von PushDebugNotification
    if(task == "stimmungsabfrage") {
      debugPrint("Workmanager fuehrt Stimmungsabfrage Callback aus");
      LocalNotification localNotification = new LocalNotification();
      localNotification.showNotification("Static Health", "Eine kleine Stimmungsabfrage");
    }
    return Future.value(true);
  });
}


//Initialisierung des Workermanagers
void initWorkManager() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  debugPrint("Workmanager initalized");
  Workmanager.registerPeriodicTask("Stimmungsabfrage", "stimmungsabfrage");       //Eine periodische Task wird alle 15 min ausgefuehrt
}


