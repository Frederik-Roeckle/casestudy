import 'package:flutter_app_casestudy/Kategorien.dart';

class Routes extends Kategorien {
  static final List<Kategorien> items = [
    Kategorien(name: "Kalender", route: "/Kalender"),
    Kategorien(name: "Physiotherapeut", route: "/Physiotherapeut"),
    Kategorien(name: "Tagebuch", route: "/Tagebuch"),
  ];
  static List<Kategorien> fetchAll() {
    return Routes.items;
  }
}
