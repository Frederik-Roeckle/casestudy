import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/Physiotherapie.dart';
import 'package:flutter_app_casestudy/Routing/Routes.dart';
import 'package:flutter_app_casestudy/Tagebuch.dart';
import 'homescreen.dart';
import 'Kalender.dart';

void main() {
  final routes = Routes.fetchAll();
  return runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the FirstScreen widget.
      '/': (context) => HomescreenList(routes),
      // When navigating to the "/second" route, build the SecondScreen widget.
      '/Kalender': (context) => Kalender(),
      '/Physiotherapeut': (context) => Physiotherapie(),
      '/Tagebuch': (context) => Tagebuch(),
    },
  ));
}
