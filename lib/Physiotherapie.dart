import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/physiotherapie2.dart';
import 'package:flutter_app_casestudy/styles.dart';

class Physiotherapie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Übersicht", style: Styles.headerLarge),
        backgroundColor: Styles.appBarColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  color: Styles.STRONG_GREEN,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: new TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/PhysiotherapieKraft'),
                child: new Text("Kraftübungen", style: Styles.textDefault),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: Container(
              padding: EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                  color: Styles.STRONG_GREEN,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: new TextButton(
                //onPressed: () => Navigator.pushNamed(context),
                child: new Text("Atemübungen", style: Styles.textDefault),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
