import 'package:flutter_app_casestudy/Tagebuch/Datenbank.dart';
import 'package:intl/intl.dart';
import '../styles.dart';
import 'package:flutter/material.dart';

class Tagebucheintraege extends StatefulWidget {
  _Tagebucheintraege createState() => _Tagebucheintraege();
}

class _Tagebucheintraege extends State<Tagebucheintraege> {
  Datenbank db = new Datenbank();
  String debug;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Tagebuch", style: Styles.headerLarge),
            backgroundColor: Styles.appBarColor),
        body: FutureBuilder(
          future: db.diaries(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                  return _buildRow(snapshot.data[i]);
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Fehler'),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Widget _buildRow(Diary diary) {
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
                color: Styles.strongGreen,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: TextButton(
                onPressed: () => Navigator.pushNamed(
                    context, '/EintragBearbeiten',
                    arguments: diary),
                child: Text(
                  'Eintrag vom: ' + dateResult,
                  style: Styles.textDefault,
                ))));
  }
}
