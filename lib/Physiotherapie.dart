import 'styles.dart';
import 'package:flutter/material.dart';

class Physiotherapie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Physiotherapie", style: Styles.headerLarge),
            backgroundColor: Styles.appBarColor),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [_routingTile(context, 'Kraft', '/Physiotherapie/Kraft')],
        ));
  }

  Widget _routingTile(context, String funktion, String route) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Container(
        padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            color: Styles.tileColor,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: new TextButton(
            onPressed: () => Navigator.pushNamed(context, route),
            child: new Text(funktion, style: Styles.textDefault)),
      ),
    );
  }
}
