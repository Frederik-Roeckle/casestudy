import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/styles.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app_casestudy/MoodPoll/MoodDatabase.dart';
import 'package:flutter_app_casestudy/MoodPoll/MoodEntry.Dart';


class MoodStatistic extends StatefulWidget {
  @override
  _MoodStatisticController createState() => _MoodStatisticController();
}

class _MoodStatisticController extends State<MoodStatistic> {
  @override
  Widget build(BuildContext context) => _MoodStatisticView(this);

  Future<List<MoodEntry>> _retrieveAllMoodElementsFromDatabase() async {
    MoodDatabase moodDatabase = new MoodDatabase();
    await moodDatabase.initaliseDatabase();
    return moodDatabase.retrieveElements();
  }
}


class _MoodStatisticView extends StatelessWidget {
  final _MoodStatisticController state;
  _MoodStatisticView(this.state, {Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stimmung-Statistik"),
        backgroundColor: Styles.STRONG_GREEN,
      ),
      body: FutureBuilder(
        future: state._retrieveAllMoodElementsFromDatabase(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return ListView(
              children: <Widget>[
                Padding(
                  padding: new EdgeInsets.all(10),
                  child:Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.height * 0.7,
                    child: charts.TimeSeriesChart(
                      [
                        new charts.Series<MoodEntry, DateTime>(
                        id: "Stimmung",
                        colorFn: (MoodEntry moodEntry, _) => _getBarChartColorForMoodPoints(moodEntry.moodInPoints),
                        domainFn: (MoodEntry moodEntry, _) => DateTime.parse(moodEntry.dateTime),
                        measureFn: (MoodEntry moodEntry, _) => _getBarPointsForMoodPoints(moodEntry.moodInPoints),
                        data: snapshot.data,
                        )
                      ],
                      animate: true,
                      animationDuration: Duration(milliseconds: 1500),
                      defaultRenderer: new charts.BarRendererConfig<DateTime>(),
                      defaultInteractions: false,
                      behaviors: [new charts.SelectNearest(), new charts.DomainHighlighter()],
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      //Darkred - 0 MoodPoints
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Center(
                            child: Text('\u{1F62D}'),
                        ),
                        width: 25,
                        height: 25,
                        color: Color.fromRGBO(0xD3, 0x2F, 0x2F, 0x0F),
                      ),

                      //Orange - 20 MoodPoints
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Text('\u{1F622}'),
                        ),
                        width: 25,
                        height: 25,
                        color: Color.fromRGBO(0xE6, 0x4A, 0x19, 0x0F),
                      ),

                      //Yellow - 40 MoodPoints
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Text('\u{1F610}'),
                        ),
                        width: 25,
                        height: 25,
                        color: Color.fromRGBO(0xFB, 0xC0, 0x2D, 0x0F),
                      ),

                      //Green - 60 MoodPoints
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Text('\u{1F642}'),
                        ),
                        width: 25,
                        height: 25,
                        color: Color.fromRGBO(0x38, 0x8E, 0x3C, 0x0F),
                      ),

                      //Blue - 80 MoodPoints
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Text('\u{1F600}'),
                        ),
                        width: 25,
                        height: 25,
                        color: Color.fromRGBO(0x21, 0x96, 0xF3, 0x0F),
                      ),

                      //Purple - 100 MoodPoints
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Center(
                          child: Text('\u{1F601}'),
                        ),
                        width: 25,
                        height: 25,
                        color: Color.fromRGBO(0x9C, 0x27, 0xB0, 0x0F),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if(snapshot.hasError) {
              return Container(
                child: Center(
                  child: Text("Error occured"),
                ),
              );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  charts.Color _getBarChartColorForMoodPoints(double moodPoints) {
    if(moodPoints == 0) {
      return charts.MaterialPalette.red.shadeDefault;
    } else if(moodPoints == 20) {
      return charts.MaterialPalette.deepOrange.shadeDefault;
    } else if(moodPoints == 40) {
      return charts.MaterialPalette.yellow.shadeDefault;
    } else if(moodPoints == 60) {
      return charts.MaterialPalette.green.shadeDefault;
    } else if(moodPoints == 80) {
      return charts.MaterialPalette.blue.shadeDefault;
    } else {
      return charts.MaterialPalette.purple.shadeDefault;
    }
  }

  int _getBarPointsForMoodPoints(double moodPoints) {
    if(moodPoints == 0) {
      return 3;
    } else {
      return moodPoints.toInt();
    }
  }
}
