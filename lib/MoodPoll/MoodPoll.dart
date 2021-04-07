import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/DailyReminder/DailyReminder.dart';
import 'package:flutter_app_casestudy/styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodDatabase.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodEntry.Dart';
import 'package:path/path.dart';


class MoodPoll extends StatefulWidget {
  @override
  _MoodPollController createState() => _MoodPollController();
}

class _MoodPollController extends State<MoodPoll> {
  @override
  Widget build(BuildContext context) => _MoodPollView(this);

  //Global Var goes here
  bool jaListTileSelected = false;
  double sliderValue = 50;
  List<Color> btnColorSchmerzabfrage = [Styles.LIGHT_GREY, Styles.LIGHT_GREY];
  double visibilitySchmerzabfrage = 1;
  bool abschlussButtonEnabled = false;
  int schmerz = 0;


  //Controller

  final schmerzAbfrageController = TextEditingController();
  final psychischeVerfassungController = TextEditingController();


  //UI Handler and Co. below

  void buttonSchmerzHandler(int position) {
    if(position == 0) {
      if(btnColorSchmerzabfrage[0] == Styles.LIGHT_GREY) {
        btnColorSchmerzabfrage[0] = Styles.LIGHT_GREEN;
        btnColorSchmerzabfrage[1] = Styles.LIGHT_GREY;
        schmerz = 1;
        setVisibiltySchmerzabfrage(1);
        setAbschlussButtonVisibilityDependingOnUserInput();
      } else {
        btnColorSchmerzabfrage[0] = Styles.LIGHT_GREY;
        schmerz = 0;
        setVisibiltySchmerzabfrage(0);
        setAbschlussButtonVisibilityDependingOnUserInput();
      }
    } else if(position == 1) {
      if(btnColorSchmerzabfrage[1] == Styles.LIGHT_GREY) {
        btnColorSchmerzabfrage[0] = Styles.LIGHT_GREY;
        btnColorSchmerzabfrage[1] = Styles.LIGHT_GREEN;
        schmerz = 0;
        setAbschlussButtonVisibilityDependingOnUserInput();
        setVisibiltySchmerzabfrage(0);
      } else {
        btnColorSchmerzabfrage[1] = Styles.LIGHT_GREY;
        schmerz = 0;
        setVisibiltySchmerzabfrage(0);
        setAbschlussButtonVisibilityDependingOnUserInput();
      }
    }
  }

  void setVisibiltySchmerzabfrage(double value) {
    setState(() {
      this.visibilitySchmerzabfrage = value;
    });
  }

  void buttonAbschlussHandler() async {

    //TODO Speichern der Infos in der DB
    MoodDatabase moodDatabase = new MoodDatabase();
    String currentDate = DateTime.now().toIso8601String();
    MoodEntry moodEntry = MoodEntry(
      dateTime: currentDate,
      moodInPoints: sliderValue,
      schmerzen: schmerz,
      schmerzBeschreibung: schmerzAbfrageController.text,
      psychologischeVerfassung: psychischeVerfassungController.text,
    );
    await moodDatabase.initaliseDatabase();
    await moodDatabase.insertElement(moodEntry);
    List<MoodEntry> dbList = await moodDatabase.retrieveElements();
    debugPrint(dbList.last.moodInPoints.toString());
  }

  void setAbschlussButtonVisibilityDependingOnUserInput() {
    if((sliderValue == 0 || sliderValue == 20 || sliderValue == 40 || sliderValue == 60 || sliderValue == 80 || sliderValue == 100) && (btnColorSchmerzabfrage[0] == Styles.LIGHT_GREEN || btnColorSchmerzabfrage[1] == Styles.LIGHT_GREEN)) {
      abschlussButtonEnabled = true;
    } else {
      abschlussButtonEnabled = false;
    }
  }

  void sliderHandler(double value) {
    setState(() {
      sliderValue = value;
      setAbschlussButtonVisibilityDependingOnUserInput();
    });
  }

  //get the Unicode Smiley for the mood back
  String getSmileyForMood() {
    if(sliderValue == 0) {
      return '\u{1F62D}';
    } else if(sliderValue == 20) {
      return '\u{1F622}';
    } else if(sliderValue == 40) {
      return '\u{1F610}';
    } else if(sliderValue == 60) {
      return '\u{1F642}';
    } else if(sliderValue == 80) {
      return '\u{1F600}';
    } else {
      return '\u{1F601}';
    }
  }

}

class _MoodPollView extends StatelessWidget{

  // Ueber state wird auf das Controller Objekt referenziert wo alle Handler sind.
  final _MoodPollController state;
  const _MoodPollView(this.state, {Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stimmungsabfrage"),
        backgroundColor: Styles.STRONG_GREEN,

      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Stimmungsabfrage(context),
            PsychischeVerfassung(context),
            Schmerzabfrage(context),
            SchmerzabfrageStelle(context),
            Abschlussbutton(context),
            DailyReminder(),
          ],
        ),
      ),
    );

  }


  Widget Stimmungsabfrage(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: Styles.LIGHT_GREEN,
                borderRadius: BorderRadius.all(
                    Radius.circular(5)
                ),
              ),
              child: Center(
                child: Text(
                    "Wie geht es Dir heute?",
                    style: Styles.TEXT_DEFAULT
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Slider(
                value: state.sliderValue,
                onChanged: state.sliderHandler,
                divisions: 5,
                min: 0,
                max: 100,
                label: state.getSmileyForMood(),
                activeColor: Color(0xFF00CC5C),
                inactiveColor: Color(0xFFE81616),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Schmerzabfrage(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  color: Styles.LIGHT_GREEN,
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)
                  )
              ),
              child: Center(
                child: Text(
                  "Hast du Schmerzen?",
                  style: Styles.TEXT_DEFAULT,
                ),
              ),
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: RaisedButton(
                        onPressed: () => state.buttonSchmerzHandler(0),
                        child: Text("Ja"),
                        color: state.btnColorSchmerzabfrage[0]
                    ),
                  ),

                  SizedBox(
                    width:  MediaQuery.of(context).size.width * 0.3,
                    child:  RaisedButton(
                        onPressed: () => state.buttonSchmerzHandler(1),
                        child: Text("Nein"),
                        color: state.btnColorSchmerzabfrage[1]
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget SchmerzabfrageStelle (BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Opacity(
        opacity: state.visibilitySchmerzabfrage,
        child: Center(
          child: Column(
            crossAxisAlignment:  CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                  color: Styles.LIGHT_GREEN,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Wenn ja an welchen Stellen?",
                    style: Styles.TEXT_DEFAULT,
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Schmerzen",
                    fillColor: Styles.LIGHT_GREY,
                  ),
                  controller: state.schmerzAbfrageController,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget PsychischeVerfassung (BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Center(
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                  color: Styles.LIGHT_GREEN,
                  borderRadius: BorderRadius.all(
                      Radius.circular(5)
                  )
              ),
              child: Center(
                child: Text(
                  "In welcher psychischen Verfassung bist du heute?",
                  style: Styles.TEXT_DEFAULT,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Psychische Verfassung",
                ),
                controller: state.psychischeVerfassungController,
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget Abschlussbutton(BuildContext context) {
    return Container(
        child: RaisedButton(
          onPressed: state.abschlussButtonEnabled ? state.buttonAbschlussHandler: null,
          color: Styles.LIGHT_GREEN,
          disabledColor: Colors.red,
          child: Text("Abschluss"),
        ),
    );
  }


}

