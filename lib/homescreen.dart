import 'styles.dart';
import 'package:flutter/material.dart';

class HomescreenList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Übersicht")),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _function("Kalender"),
            _function("Tagebuch"),
            _function("Physiotherapie")
          ],
        ));
  }

  Widget _function(String title) {
    return Container(
      padding: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
      child:
          Text(title, textAlign: TextAlign.center, style: Styles.textDefault),
    );
  }
}
