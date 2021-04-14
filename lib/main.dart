import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_casestudy/Lockscreen/Lockscreen.dart';
import 'package:flutter_app_casestudy/Physiotherapie.dart';
import 'package:flutter_app_casestudy/models/userr.dart';
import 'package:flutter_app_casestudy/physiotherapie2.dart';
import 'package:flutter_app_casestudy/services/auth.dart';
import 'package:flutter_app_casestudy/wrapper.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';
import 'Kalender.dart';
import 'MoodPoll/MoodPoll.dart';
import 'package:flutter_app_casestudy/Tagebuch/NeuerEintrag.dart';
import 'package:flutter_app_casestudy/Tagebuch/Tagebucheintraege.dart';
import 'package:flutter_app_casestudy/Tagebuch/EintragBearbeiten.dart';
import 'Tagebuch/Tagebuch.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
          '/Kalender': (context) => Kalender(),
          '/Physiotherapie': (context) => Physiotherapie(),
          '/Tagebuch': (context) => Tagebuch(),
          '/MoodPoll': (context) => MoodPoll(),
          '/NeuerEintrag': (context) => NeuerEintrag(),
          '/Tagebucheintraege': (context) => Tagebucheintraege(),
          '/EintragBearbeiten': (context) => EintragBearbeiten(),
          '/PhysiotherapieKraft': (context) => PhysiotherapieKraft(),
        }),
        lockScreen: Lockscreen(),
      ),
    );
  }
}

// void main() {
//   return runApp(MaterialApp(
//     initialRoute: '/',
//     routes: {
//       // When navigating to the "/" route, build the FirstScreen widget.
//       '/': (context) => HomescreenList(),
//       // When navigating to the "/second" route, build the SecondScreen widget.
//       '/Kalender': (context) => Kalender(),
//       '/Physiotherapie': (context) => Physiotherapie(),
//       '/Tagebuch': (context) => Tagebuch(),
//       '/MoodPoll': (context) => MoodPoll(),
//     },
//   ));
// }
