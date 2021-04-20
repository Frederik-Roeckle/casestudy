import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/styles.dart';

class StimmungStartSeite extends StatefulWidget {
  @override
  _StimmungStartSeiteState createState() => _StimmungStartSeiteState();
}

//Klasse Uebersicht Stimmungsabfrage und Statistik
class _StimmungStartSeiteState extends State<StimmungStartSeite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Stimmung", style: Styles.headerLarge),
            backgroundColor: Styles.appBarColor),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _routingTile(context, 'Stimmungsabfrage', '/MoodPoll'),
            _routingTile(context, 'Statistik', '/Stimmung-Statistik'),
          ],
        ));
  }

  Widget _routingTile(context, String funktion, String route) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Container(
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Styles.STRONG_GREEN,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: new TextButton(
              onPressed: () => Navigator.pushNamed(context, route),
              child: new Text(funktion, style: Styles.textDefault)),
        )
    );
  }
}
