import 'package:flutter_app_casestudy/Tagebuch/Datenbank.dart';

import '../styles.dart';
import 'package:flutter/material.dart';

class Tagebucheintraege extends StatefulWidget {
  _Tagebucheintraege createState() => _Tagebucheintraege();
}

class _Tagebucheintraege extends State<Tagebucheintraege> {
  Datenbank db = new Datenbank();
  String debug;
  //Dynamisches bauen der Anzeige für die Anzeige der Tagebucheintraege.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Tagebuch", style: Styles.headerLarge),
          backgroundColor: Styles.appBarColor),
      body: FutureBuilder(
        future: db.diaries(), //Abrufen aller Tagebucheintraege
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //sobald ein Tagebucheintrag vorhanden wird für diesen eine Kachel erzeugt
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return _buildRow(snapshot.data[i]);
              },
            );
          } else if (snapshot.hasError) {
            //Bei Fehler beim Abrufen aus der Datenbank
            return Center(
              child: Text('Fehler'),
            );
          } else {
            //Ladeanzeige, während Daten aus der Datenbank geholt werden
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  //Bauen der jeweiligen Kacheln für einen Tagebucheintrag, mit den Daten aus der Datenbank
  Widget _buildRow(Diary diary) {
    debugPrint('diary.date$diary');
    var onlyDate = diary.date.split("T");
    var dateInFormatText = onlyDate[0].split("-");

    String dateResult = dateInFormatText[2] +
        '.' +
        dateInFormatText[1] +
        '.' +
        dateInFormatText[0];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Styles.STRONG_GREEN,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, '/EintragBearbeiten',
              arguments: diary),
          child: Text(
            'Eintrag vom: ' + dateResult,
            style: Styles.textDefault,
          ),
        ),
      ),
    );
  }
}
