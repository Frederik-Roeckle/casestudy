import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodDatabase.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodEntry.Dart';


class MoodPoll extends StatefulWidget {
  @override
  _MoodPollController createState() => _MoodPollController();
}

class _MoodPollController extends State<MoodPoll> {

  MoodDatabase moodDatabase;
  Future<List<MoodEntry>> entryList;

  @override
  Widget build(BuildContext context) => _MoodPollView(this);

  // Event Handlers, Init Code goes here


  @override
  void initState() {
    moodDatabase = new MoodDatabase();
    moodDatabase.initaliseDatabase("Test").then((value) => {});

    super.initState();
  }


  void handleActionButtonPressed() async {
    var moodEntry = MoodEntry(
      id: 102,
      name: "Thomas"
    );
    moodDatabase.insertElement(moodEntry);
    print(await moodDatabase.retrieveElements());
  }

  futureBuilderHandler(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    List<Widget> children;
    if(snapshot.hasData) {
      children = <Widget>[
        Text(snapshot.data.toString()),
      ];
    } else {
      children = <Widget>[
        Icon(Icons.refresh)
      ];
    }
    return Center(
      child: Column(
        children: children,
      ),
    );

  }

   final myController = TextEditingController();



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
      body: Row(
        children: [
          futureBuilderContainer(context),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: state.handleActionButtonPressed,
        child: Icon(Icons.add),
      ),

    );
  }

  FutureBuilder futureBuilderContainer(BuildContext context) {
    return (
        FutureBuilder(
          future: state.entryList,
          builder: (context, snapshot) => state.futureBuilderHandler(context, snapshot),
        )
    );
  }
}

