import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodDatabase.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodEntry.Dart';


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
  double visibilityButtonAbschluss = 0;
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
    //debugPrint(await moodDatabase.retrieveElements().toString());
  }

  void setAbschlussButtonVisibilityDependingOnUserInput() {
    if((sliderValue == 0 || sliderValue == 20 || sliderValue == 40 || sliderValue == 60 || sliderValue == 80 || sliderValue == 100) && (btnColorSchmerzabfrage[0] == Styles.LIGHT_GREEN || btnColorSchmerzabfrage[1] == Styles.LIGHT_GREEN)) {
        visibilityButtonAbschluss = 1;
    } else {
      visibilityButtonAbschluss = 0;
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

      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Stimmungsabfrage(context),
            Schmerzabfrage(context),
            SchmerzabfrageStelle(context),
            PsychischeVerfassung(context),
            Abschlussbutton(context),

          ],
        ),
      ),
    );

  }


  Widget Stimmungsabfrage(BuildContext context) {
    return Center(
      child: Column(
      children: <Widget>[
        Container(
          child: Text("Wie geht es Dir heute?"),
          ),
        Container(
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
    );
  }

  Widget Schmerzabfrage(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Hast du Schmerzen?"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              RaisedButton(
                onPressed: () => state.buttonSchmerzHandler(0),
                child: Text("Ja"),
                color: state.btnColorSchmerzabfrage[0]
              ),
              RaisedButton(
                onPressed: () => state.buttonSchmerzHandler(1),
                child: Text("Nein"),
                color: state.btnColorSchmerzabfrage[1]
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget SchmerzabfrageStelle (BuildContext context) {
    return Opacity(
      opacity: state.visibilitySchmerzabfrage,
      child: Center(
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.center,
          children: <Widget>[
            Text("Wenn ja an welchen Stellen?"),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Schmerzen",
              ),
              controller: state.schmerzAbfrageController,
            ),
          ],
        ),
      ),
    );
  }

  Widget PsychischeVerfassung (BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment:  CrossAxisAlignment.center,
        children: <Widget>[
          Text("In welcher psychischen Verfassung bist du heute?"),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Verfassung",
            ),
            controller: state.psychischeVerfassungController,
          ),
        ],
      ),
    );
  }

  Widget Abschlussbutton(BuildContext context) {
    return Opacity(
      opacity: state.visibilityButtonAbschluss,
      child: RaisedButton(
        onPressed: state.buttonAbschlussHandler,
        child: Text("Abschluss"),
      ),
    );
  }


}

