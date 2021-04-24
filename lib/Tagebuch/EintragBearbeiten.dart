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
  bool _view = false;

  final textFieldController = TextEditingController();
  final scrollController = ScrollController();

  Datenbank db = new Datenbank();
  //Laden der Bearbeitungsanzeige
  @override
  Widget build(BuildContext context) {
    final Diary args = ModalRoute.of(context)
        .settings
        .arguments; //Zu bearbeitendes Tagebuchobjekt wurde an die Route übergeben
    if (_diaryText == null) {
      //Laden der Werte des Tagebucheintrages in das Textfeld und die Datumanzeige, wenn noch keine gesetzt
      _diaryText = args.entry;
      textFieldController.text = _diaryText;
      _date = args.date;
      _newDate = args.date;
      _dateTime = DateTime.parse(args.date);
      _dateFormatter(args
          .date); //Formatieren des Datums, fuer die Anzeige des Datum-Buttons
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

  //Rueckgabe des Textfelds
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

  //Button zur Bestaetigung der Aenderungen
  Widget _submitEntry() {
    return Container(
        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
        //padding: EdgeInsets.all(30.0),
        decoration: BoxDecoration(
            color: Styles.LIGHT_GREEN,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: new TextButton(
          onPressed: () => _changeEntry(_date, textFieldController.text),
          child: Text(
            'Eintrag bearbeiten',
            style: Styles.textDefault,
          ),
        ));
  }

  //Delete-Button
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

  //Delete-Methode zum Loeschen aus der Datenbank
  _deleteDiary(String date) async {
    //await db.deleteAllDiaries(date);
    await db
        .deleteDiary(date)
        .onError((error, stackTrace) => _buildPopupDialog(context, 'Fehler'))
        .whenComplete(
          () => Navigator.popUntil(context, ModalRoute.withName('/Tagebuch')),
        );
  }

  //Methode zur Aenderung des Kalendereintrags
  Future<void> _changeEntry(String date, String text) async {
    bool suc = false;

    debugPrint('Date: $date');
    if (_newDate == _date) {
      await db.updateDiary(date, text).whenComplete(() => suc = true);
    } else {
      await db.insertDiary(_newDate, text);
      await db.deleteDiary(date).whenComplete(() => suc = true);
    }
    if (suc == true) {
      return await _buildPopupDialog(context, "Erfolgreich gespeichert!");
    } else {
      return await _buildPopupDialog(context, "Fehler!");
    }
  }

  //Methode die schließen des Erfolg-Popups erwartet, um den Nutzer weiter zu routen,
  Future<void> _buildPopupDialog(BuildContext context, String status) async {
    //Da Routen aus Popup nicht möglich
    await _showPopupDialog(context, status);
    if (_view == true) {
      Navigator.popUntil(context, ModalRoute.withName('/Tagebuch'));
    }
  }

  //Popup nach Aenderung
  Future<Widget> _showPopupDialog(BuildContext context, String status) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => (AlertDialog(
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
              _view = true;
              Navigator.of(context).pop();
            },
            child: Text('Close', style: TextStyle(color: Color(0xff000000))),
          ),
        ],
      )),
    );
  }

  //Date-Picker zur Aenderung des Datums des Tagebuchs
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
          style: TextStyle(color: Styles.STRONG_GREY, fontSize: 20),
        ),
      )),
    );
  }

  //Datum muss fuer schoene Anzeige im Button formatiert werden
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
