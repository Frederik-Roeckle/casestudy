import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/styles.dart';
import 'package:flutter_app_casestudy/Tagebuch/Datenbank.dart';

class NeuerEintrag extends StatefulWidget {
  @override
  _NeuerEintrag createState() => _NeuerEintrag();
}

class _NeuerEintrag extends State<NeuerEintrag> {
  DateTime _dateTime;
  String _choosingDate = 'Wähle ein Datum aus!';

  final textFieldController = TextEditingController();
  final scrollController = ScrollController();

  Datenbank db = new Datenbank();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neuer Eintrag", style: Styles.headerLarge),
        backgroundColor: Styles.appBarColor,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _datePicker(),
            _textField(),
            _submitEntry(),
          ]),
    );
  }

  Widget _submitEntry() {
    return Container(
        //padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            color: Styles.lightGreen,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: new TextButton(
          onPressed: () => _newEntry(_dateTime, textFieldController.text),
          child: Text(
            'Eintrag anlegen',
            style: Styles.textDefault,
          ),
        ));
  }

  Widget _textField() {
    return Container(
        /* padding: EdgeInsets.all(15.0), */
        margin: EdgeInsets.all(10),
        height: 300,
        child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Liebes Tagebuch...',
              alignLabelWithHint: true,
            ),
            controller: textFieldController,
            scrollController: scrollController,
            maxLines: 60,
            onSubmitted: (value) {
              _newEntry(_dateTime, textFieldController.text);
            }));
  }

  Future<Widget> _newEntry(DateTime date, String text) async {
    bool suc = false;
    String _date = date.toIso8601String();
    debugPrint('DateTime: $_dateTime');
    await db.insertDiary(_date, text).whenComplete(() => suc = true);
    if (suc == true) {
      return showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context, suc),
      );
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) => _buildPopupDialog(context, suc),
      );
    }
  }

  Widget _buildPopupDialog(BuildContext context, bool suc) {
    String status;
    if (suc == true) {
      status = "Erfolgreich gespeichert!";
    } else {
      status = "Fehler: Tagebucheintrag bereits vorhanden";
    }
    return new AlertDialog(
      title: const Text('Neuer Tagebucheintrag'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            status,
            style: TextStyle(color: Color(0xff000000)),
          ),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close', style: TextStyle(color: Color(0xff000000))),
        ),
      ],
    );
  }

  Widget _datePicker() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: (TextButton(
        onPressed: () {
          showDatePicker(
            context: context,
            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
            firstDate: DateTime(2001),
            lastDate: DateTime(2222),
          ).then((date) {
            setState(() {
              _dateTime = date;
              _dateFormatter(date);
            });
            debugPrint('DateTime: $_dateTime');
          });
        },
        child: new Text(
          _choosingDate,
          style: TextStyle(color: Styles.strongGrey, fontSize: 20),
        ),
      )),
    );
  }

  _dateFormatter(DateTime date) {
    String dateString = date.toIso8601String();
    var onlyDate = dateString.split("T");
    var dateInFormatText = onlyDate[0].split("-");

    String dateResult = dateInFormatText[2] +
        '.' +
        dateInFormatText[1] +
        '.' +
        dateInFormatText[0];
    _choosingDate = dateResult;
  }
}
