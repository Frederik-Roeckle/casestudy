import 'package:flutter_app_casestudy/services/auth.dart';
import 'styles.dart';
import 'package:flutter/material.dart';

class HomescreenList extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Übersicht", style: Styles.headerLarge),
        backgroundColor: Styles.STRONG_GREEN,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _routingTile(context, 'Kalender', '/Kalender'),
          _routingTile(context, 'Physiotherapie', '/Physiotherapie'),
          _routingTile(context, 'Tagebuch', '/Tagebuch'),
          _routingTile(context, 'Stimmung', '/Stimmung'),
        ],
      ),
    );
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
        ));
  }
}
