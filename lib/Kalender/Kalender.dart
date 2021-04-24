import '../styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import './Datenbank.dart';

class Kalender extends StatefulWidget {
  @override
  _Kalender createState() => _Kalender();
}

class _Kalender extends State<Kalender> {
  List<Appointment> meetings = <Appointment>[];
  Datenbank db = new Datenbank();

  final _formKey = GlobalKey<FormState>();
  bool _view = false;
  DateTime __start;
  DateTime __end;
  CalendarController _calendarController;
  var textFieldController = TextEditingController();
  //Initialsieren des States
  @override
  void initState() {
    _calendarController = CalendarController();
    db.databaseInit();
    super.initState();
  }

  //Bauen des Hauptwidgets
  @override
  Widget build(BuildContext context) {
    var view2 = CalendarView.week;

    return Scaffold(
      appBar: AppBar(
        title: Text('Kalender'),
        backgroundColor: Styles.STRONG_GREEN,
      ),
      //FutureBuilder baut Widget dynamisch während Daten aus der Datenbank geladen werden
      body: FutureBuilder(
        future: _loadEntries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //Kalender des Packages syncfusion_flutter_calendar
            return SfCalendar(
              view: view2,
              firstDayOfWeek: 1,
              initialDisplayDate: DateTime.now(),
              initialSelectedDate: DateTime.now(),
              onTap: _calenderTapped,
              controller: _calendarController,
              dataSource: MeetingDataSource(getAppointments()),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Datenbank nicht erreichbar!'),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Styles.LIGHT_GREEN,
          onPressed: () => _newEvent(context)),
    );
  }

  //Wird aufgerufen, wenn auf den Kalender getippt wird, erwartet das Schließen des eigentlichen Popups
  _calenderTapped(CalendarTapDetails calendarTapDetails) async {
    await showCalendarTapped(calendarTapDetails);
    if (_view == true) {
      // Erneutes aufrufen des Kalenders, Routing über diese Zwischenmethode, da von Popup kein Zugriff auf normalen Context,
      Navigator.popAndPushNamed(context, '/Kalender'); // Routen sonst verbuggt
    }
  }

//Wird aufgerufen, wenn auf den plus-Button gedrückt wird, erwartet das Schließen des eigentlichen Popups
  Future<void> _newEvent(BuildContext context) async {
    await _showNewEvent(context);
    if (_view == true) {
      // Erneutes aufrufen des Kalenders, Routing über diese Zwischenmethode, da von Popup kein Zugriff auf normalen Context,
      Navigator.popAndPushNamed(context, '/Kalender'); // Routen sonst verbuggt
    }
  }

  //Anzeigen des Popups zum Erstellen eines neuen Kalendereintrags
  Future<void> _showNewEvent(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Titel'),
                            controller: textFieldController,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Styles.LIGHT_GREEN)),
                              child: Text('Startzeit auswählen'),
                              onPressed: () => _choosingStartTime(true)),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Styles.LIGHT_GREEN)),
                              child: Text('Endzeit auswählen'),
                              onPressed: () => _choosingStartTime(false)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Styles.LIGHT_GREEN)),
                            child: Text("Submit"),
                            onPressed: () async {
                              await _addEvent();
                              //setState(() {});
                              _view = true;
                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //Anzeigen eines Timepickers für einen neuen Eintrag
  _choosingStartTime(bool bol) async {
    TimeOfDay _initialTime =
        TimeOfDay.fromDateTime(_calendarController.selectedDate);
    TimeOfDay start;
    if (bol == false) {
      _initialTime = _initialTime.addHour(1);
    }
    start = await showTimePicker(
      context: context,
      initialTime: _initialTime, //_calendarController.selectedDate
    );
    debugPrint('start$start');
    if (bol == true) {
      __start = new DateTime(
          _calendarController.selectedDate.year,
          _calendarController.selectedDate.month,
          _calendarController.selectedDate.day,
          start.hour,
          start.minute);
    } else {
      __end = new DateTime(
          _calendarController.selectedDate.year,
          _calendarController.selectedDate.month,
          _calendarController.selectedDate.day,
          start.hour,
          start.minute);
    }
  }

  //Einfügen eines neuen Eintrags in die Datenbank
  _addEvent() async {
    await db.insertAppoint(textFieldController.text, __start.toIso8601String(),
        __end.toIso8601String());
  }

  //getter für AppointmentList
  List<Appointment> getAppointments() {
    return meetings;
  }

  //Holen aller Eintraege aus der Datenbank, konvertierung dieser in Appointment-Objekte des Kalenders und Speichern in einer List
  Future<List<Appointment>> _loadEntries() async {
    List<Appoint> app = await db.appoint();
    for (int i = 0; i < app.length; i++) {
      meetings.add(Appointment(
          notes: app[i].id.toString(),
          startTime: DateTime.parse(app[i].start),
          endTime: DateTime.parse(app[i].end),
          subject: app[i].description,
          color: Styles.LIGHT_GREEN));
    }
    return meetings;
  }

  //Anzeigen eines Popups, wenn ein Kalendereintrag angeklickt wurde, welches Änderungen an diesem zulaesst
  Future<void> showCalendarTapped(CalendarTapDetails calendarTapDetails) async {
    TimeOfDay start;
    TimeOfDay end;
    DateTime _date;

    if (calendarTapDetails.targetElement == CalendarElement.appointment) {
      _view = true;
      Appointment appointment = calendarTapDetails.appointments[0];
      textFieldController.text = appointment.subject;

      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'Titel'),
                              controller: textFieldController,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Styles.LIGHT_GREEN)),
                                child: Text('Tag auswählen'),
                                onPressed: () async => _date =
                                    await showDatePicker(
                                        context: context,
                                        initialDate: appointment.startTime,
                                        firstDate: DateTime(2001),
                                        lastDate: DateTime(2222))
                                //_calendarController.selectedDate
                                ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Styles.LIGHT_GREEN)),
                                child: Text('Startzeit auswählen'),
                                onPressed: () async =>
                                    start = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          appointment
                                              .startTime), //_calendarController.selectedDate
                                    )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Styles.LIGHT_GREEN)),
                                child: Text('Endzeit auswählen'),
                                onPressed: () async =>
                                    end = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.fromDateTime(
                                          appointment
                                              .endTime), //_calendarController.selectedDate
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Styles.LIGHT_GREEN)),
                              child: Text(
                                "Submit",
                                overflow: TextOverflow.clip,
                              ),
                              onPressed: () async {
                                String text;
                                if (textFieldController.text == null) {
                                  text = appointment.subject;
                                } else {
                                  text = textFieldController.text;
                                }
                                if (start == null) {
                                  start = TimeOfDay.fromDateTime(
                                      appointment.startTime);
                                }

                                if (end == null) {
                                  end = TimeOfDay.fromDateTime(
                                      appointment.endTime);
                                }
                                if (_date == null) {
                                  _date = appointment.startTime;
                                }

                                DateTime __start = new DateTime(
                                    _date.year,
                                    _date.month,
                                    _date.day,
                                    start.hour,
                                    start.minute);
                                DateTime __end = new DateTime(
                                    _date.year,
                                    _date.month,
                                    _date.day,
                                    end.hour,
                                    end.minute);
                                await db.updateAppoint(
                                    appointment.notes,
                                    text,
                                    __start.toIso8601String(),
                                    __end.toIso8601String());
                                setState(() {});
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              child: Text("Delete"),
                              onPressed: () {
                                db.deleteAppoint(appointment.notes);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
  }
}

//Extension um automtisch eine Stunde Differenz zwischen Start- und Endzeit zu erzeugen
extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addHour(int hour) {
    return this.replacing(hour: this.hour + hour, minute: this.minute);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
