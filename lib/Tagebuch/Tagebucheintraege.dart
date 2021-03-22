import 'package:flutter_app_casestudy/Tagebuch/Datenbank.dart';

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
        )
    );
  }

  Widget _buildRow(Diary diary) {
    return new ListTile(
      title: new Text(
        diary.date.toString(),
      ),
    );
  }
}
