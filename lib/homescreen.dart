import 'styles.dart';
import 'package:flutter/material.dart';

class HomescreenList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Übersicht")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.amber[200],
              child: new FlatButton(
                  onPressed: () => Navigator.pushNamed(context, '/Kalender'),
                  child: new Text('Kalender')),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.amber[100],
              child: new FlatButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/Physiotherapie'),
                  child: new Text('Physiotherapie')),
            ),
            Container(
              padding: EdgeInsets.all(30.0),
              color: Colors.amber[200],
              child: new FlatButton(
                  onPressed: () => Navigator.pushNamed(context, '/Tagebuch'),
                  child: new Text('Tagebuch')),
            ),
          ],
        ));
  }
}
