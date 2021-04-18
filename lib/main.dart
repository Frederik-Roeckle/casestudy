import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_casestudy/Lockscreen/Lockscreen.dart';
import 'package:flutter_app_casestudy/Physio/Physiotherapie.dart';
import 'package:flutter_app_casestudy/homescreen.dart';
import 'package:flutter_app_casestudy/models/userr.dart';
import 'package:flutter_app_casestudy/Physio/physio_atem.dart';
import 'package:flutter_app_casestudy/Physio/physio_kraft.dart';
import 'package:flutter_app_casestudy/services/auth.dart';
import 'package:flutter_app_casestudy/wrapper.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_casestudy/Kalender/Kalender.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodPoll.dart';
import 'package:flutter_app_casestudy/Tagebuch/NeuerEintrag.dart';
import 'package:flutter_app_casestudy/Tagebuch/Tagebucheintraege.dart';
import 'package:flutter_app_casestudy/Tagebuch/EintragBearbeiten.dart';
import 'package:flutter_app_casestudy/Tagebuch/Tagebuch.dart';
import 'package:workmanager/workmanager.dart';

import 'Reminder/LocalNotification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initWorkManager();
  runApp(MyApp());
}

//Callback Funktion die vom Workmanager aufgerufen wird
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    //print("Native called background task at ${DateTime.now().toString()}");     //Eine Art von PushDebugNotification
    if(task == "stimmungsabfrage") {
      debugPrint("Workmanager fuehrt Stimmungsabfrage Callback aus");
      debugPrint(inputData.values.first[0].toString());

      TimeOfDay now = TimeOfDay.now();
      TimeOfDay remindTime = TimeOfDay(hour: inputData.values.first[0], minute: inputData.values.first[1]);
      double doubleRemindTime = remindTime.hour.toDouble() + (remindTime.minute.toDouble() / 60);
      double doubleNow = now.hour.toDouble() + (now.minute.toDouble() / 60);
      double timeDiff = doubleNow - doubleRemindTime;
      if(timeDiff.abs() < 0.25) {
        LocalNotification localNotification = new LocalNotification();
        localNotification.showNotification("Static Health", "Eine kleine Stimmungsabfrage");
      }

    }
    return Future.value(true);
  });
}


//Initialisierung des Workermanagers
void initWorkManager() {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  debugPrint("Workmanager initalized");
  //Workmanager().registerPeriodicTask("Stimmungsabfrage", "stimmungsabfrage");       //Eine periodische Task wird alle 15 min ausgefuehrt
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userr>.value(
      value: AuthService().user,
      initialData: null,
      child: AppLock(
        builder: (args) =>
            MaterialApp(home: Wrapper(), initialRoute: '/', routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          // '/': (context) => HomescreenList(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/homescreen': (context) => HomescreenList(),
          '/Kalender': (context) => Kalender(),
          '/Physiotherapie': (context) => Physiotherapie(),
          '/Tagebuch': (context) => Tagebuch(),
          '/MoodPoll': (context) => MoodPoll(),
          '/NeuerEintrag': (context) => NeuerEintrag(),
          '/Tagebucheintraege': (context) => Tagebucheintraege(),
          '/EintragBearbeiten': (context) => EintragBearbeiten(),
          '/PhysiotherapieKraft': (context) => PhysiotherapieKraft(),
          '/PhysiotherapieAtem': (context) => PhysiotherapieAtem(),
        }),
        lockScreen: Lockscreen(),
      ),
    );
  }
}


