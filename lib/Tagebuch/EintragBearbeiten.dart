import '../styles.dart';
import 'package:flutter_app_casestudy/Tagebuch/Datenbank.dart';
import 'package:flutter/material.dart';

class EintragBearbeiten extends StatefulWidget {
  @override
  _EintragBearbeiten createState() => _EintragBearbeiten();
}

class _EintragBearbeiten extends State<EintragBearbeiten> {
  String _date;
  DateTime _dateTime;
  String _newDate;
  String _choosingDate; //formatted String
  String _diaryText; //Textfield Inhalt

  final textFieldController = TextEditingController();
  final scrollController = ScrollController();

  Datenbank db = new Datenbank();

  @override
  Widget build(BuildContext context) {
    final Diary args = ModalRoute.of(context).settings.arguments;
    if (_diaryText == null) {
      _diaryText = args.entry;
      textFieldController.text = _diaryText;
      _date = args.date;
      _newDate = args.date;
      _dateTime = DateTime.parse(args.date);
      debugPrint('args.date $_date');
      debugPrint('_dateTime $_dateTime');
      _dateFormatter(args.date);
    }

    return Scaffold(
        appBar: AppBar(
            title: Text("Eintrag Bearbeiten", style: Styles.headerLarge),
            backgroundColor: Styles.appBarColor),
        body: ListView(
          children: [
            _datePicker(),
            _textField(),
            _submitEntry(),
            _deleteButton(),
          ],
        ));
  }

  Widget _textField() {
    return Container(
        padding: EdgeInsets.all(15.0),
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
              _changeEntry(_date, textFieldController.text);
            }));
  }

  Widget _submitEntry() {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        //padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            color: Styles.lightGreen,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: new TextButton(
          onPressed: () => _changeEntry(_date, textFieldController.text),
          child: Text(
            'Eintrag bearbeiten',
            style: Styles.textDefault,
          ),
        ));
  }

  Widget _deleteButton() {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
        //padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: new TextButton(
          onPressed: () => _deleteDiary(_date),
          child: Text(
            'Eintrag Löschen',
            style: Styles.textDefault,
          ),
        ));
  }

  _deleteDiary(String date) async {
    //await db.deleteAllDiaries(date);
    await db
        .deleteDiary(date)
        .onError((error, stackTrace) => _buildPopupDialog(context, 'Fehler'))
        .whenComplete(
          () => Navigator.pushNamed(context, '/Tagebucheintraege'),
        );
  }

  Future<Widget> _changeEntry(String date, String text) async {
    bool suc = false;

    debugPrint('Date: $date');
    if (_newDate == _date) {
      await db.updateDiary(date, text).whenComplete(() => suc = true);
    } else {
      await db.insertDiary(_newDate, text);
      await db.deleteDiary(date).whenComplete(() => suc = true);
    }
    if (suc == true) {
      return showDialog(
        context: context,
        builder: (BuildContext context) =>
            _buildPopupDialog(context, "Erfolgreich gespeichert!"),
      );
    } else {
      return showDialog(
        context: context,
        builder: (BuildContext context) =>
            _buildPopupDialog(context, "Fehler!"),
      );
    }
  }

  Widget _buildPopupDialog(BuildContext context, String status) {
    return new AlertDialog(
      title: const Text('Eintrag Bearbeiten'),
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
            Navigator.pushNamed(context, '/Tagebucheintraege');
            //Navigator.of(context).pop();
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
        onPressed: () async {
          await showDatePicker(
            context: context,
            initialDate: _dateTime == null ? DateTime.now() : _dateTime,
            firstDate: DateTime(2001),
            lastDate: DateTime(2222),
          ).then((date) {
            setState(() {
              _newDate = date.toIso8601String();
              _dateTime = date;
              _dateFormatter(date.toIso8601String());
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

  _dateFormatter(String date) {
    debugPrint('dateformatter date$date');
    var onlyDate = date.split("T");
    var dateInFormatText = onlyDate[0].split("-");

    String dateResult = dateInFormatText[2] +
        '.' +
        dateInFormatText[1] +
        '.' +
        dateInFormatText[0];
    _choosingDate = dateResult;
    debugPrint('Choosing Date: $_choosingDate');
  }
}
