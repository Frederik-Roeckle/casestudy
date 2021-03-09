import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/Physiotherapie.dart';

import 'package:flutter_app_casestudy/Tagebuch.dart';
import 'homescreen.dart';
import 'Kalender.dart';

void main() {
  return runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => HomescreenList(),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/Kalender': (context) => Kalender(),
      '/Physiotherapie': (context) => Physiotherapie(),
      '/Tagebuch': (context) => Tagebuch(),
    },
  ));
}
