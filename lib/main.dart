import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/Lockscreen/Lockscreen.dart';
import 'package:flutter_app_casestudy/Physiotherapie.dart';
import 'package:flutter_app_casestudy/Tagebuch.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';
import 'homescreen.dart';
import 'Kalender.dart';

void main() {
  return runApp(AppLock(
      builder: (args) => MaterialApp(
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the HomeScreen Widget
            '/': (context) => HomescreenList(),
            // Other Routes
            '/Kalender': (context) => Kalender(),
            '/Physiotherapie': (context) => Physiotherapie(),
            '/Tagebuch': (context) => Tagebuch(),
          },
      ),
      lockScreen: Lockscreen()
    )
  );
}

