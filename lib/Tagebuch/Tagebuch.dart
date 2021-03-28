import '../styles.dart';
import './datenbank.dart';
import 'package:flutter/material.dart';

class Tagebuch extends StatefulWidget {
  _Tagebuch createState() => _Tagebuch();
}

class _Tagebuch extends State<Tagebuch> {
  Datenbank db = new Datenbank();

  @override
  void initState() {
    super.initState();
    db.databaseInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Tagebuch", style: Styles.headerLarge),
            backgroundColor: Styles.appBarColor),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _routingTile(context, db, 'Neuer Tagebucheintrag', '/NeuerEintrag'),
            _routingTile(context, db, 'Alle Einträge', '/Tagebucheintraege'),
          ],
        ));
  }

  Widget _routingTile(context, Datenbank db, String funktion, String route) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Container(
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Styles.strongGreen,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: new TextButton(
              onPressed: () => Navigator.pushNamed(context, route),
              child: new Text(funktion, style: Styles.textDefault)),
        ));
  }
}
