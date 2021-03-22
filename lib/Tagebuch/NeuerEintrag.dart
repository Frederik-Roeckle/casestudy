import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/styles.dart';
import 'package:flutter_app_casestudy/Tagebuch/Datenbank.dart';

class NeuerEintrag extends StatefulWidget {
  @override
  _NeuerEintrag createState() => _NeuerEintrag();
}

class _NeuerEintrag extends State<NeuerEintrag> {
  DateTime _dateTime;
  String _formattedDate;
  final textFieldController = TextEditingController();

  Datenbank db = new Datenbank();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neuer Tagebucheintrag", style: Styles.headerLarge),
        backgroundColor: Styles.appBarColor,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                    firstDate: DateTime(2001),
                    lastDate: DateTime(2222),
                  ).then((date) {
                    setState(() {
                      _dateTime = date;

                    });
                    debugPrint('DateTime: $_dateTime');
                  });
                },
                child: new Text('Pick a date!')),
            TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Neuer Eintrag',
                ),
                controller: textFieldController,
                onSubmitted: (value) {
                  _newEntry(_dateTime, textFieldController.text);
                }),
          ]),
    );
  }

  Future<void> _newEntry(DateTime date, String text) async {
    String _date = date.toIso8601String();
    debugPrint('DateTime: $_dateTime');
    await db.insertDiary(_date, text);
    List<Diary> liste = await db.diaries();
    debugPrint(liste.last.entry);
  }
}
