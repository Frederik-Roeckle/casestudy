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

  //UI Handler and Co. below

  void jaSchmerzHandler() {
    setState(() {
      if(btnColorSchmerzabfrage[0] == Styles.LIGHT_GREY) {
        btnColorSchmerzabfrage[0] = Styles.LIGHT_GREEN;
        btnColorSchmerzabfrage[1] = Styles.LIGHT_GREY;
      } else {
        btnColorSchmerzabfrage[0] = Styles.LIGHT_GREY;
        btnColorSchmerzabfrage[1] = Styles.LIGHT_GREEN;
      }
    });
  }

  void neinSchmerzHandler() {
    setState(() {
      if(btnColorSchmerzabfrage[1] == Styles.LIGHT_GREY) {
        btnColorSchmerzabfrage[1] = Styles.LIGHT_GREEN;
        btnColorSchmerzabfrage[0] = Styles.LIGHT_GREY;
      } else {
        btnColorSchmerzabfrage[1] = Styles.LIGHT_GREY;
        btnColorSchmerzabfrage[0] = Styles.LIGHT_GREEN;
      }
    });
  }




  void sliderHandler(double value) {
    setState(() {
      sliderValue = value;
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
        title: Text("Hi"),

      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Stimmungsabfrage(context),
            Schmerzabfrage(context),

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
        children: <Widget>[
          Text("Hast du Schmerzen?"),
          Row(
            children: <Widget>[
              RaisedButton(
                onPressed: state.jaSchmerzHandler,
                child: Text("Ja"),
                color: state.btnColorSchmerzabfrage[0]
              ),
              RaisedButton(
                onPressed: state.neinSchmerzHandler,
                child: Text("Nein"),
                color: state.btnColorSchmerzabfrage[1]
              ),
            ],
          ),
        ],
      ),
    );
  }


}

