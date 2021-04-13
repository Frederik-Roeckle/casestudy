import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/styles.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class MoodStatistic extends StatefulWidget {
  @override
  _MoodStatisticController createState() => _MoodStatisticController();
}

class _MoodStatisticController extends State<MoodStatistic> {
  @override
  Widget build(BuildContext context) => _MoodStatisticView(this);
}


class _MoodStatisticView extends StatelessWidget {
  // Ueber state wird auf das Controller Objekt referenziert wo alle Handler sind.
  final _MoodStatisticController state;
  _MoodStatisticView(this.state, {Key key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stimmung-Statistik"),
        backgroundColor: Styles.STRONG_GREEN,
      ),
      body: Container(
        child: charts.TimeSeriesChart(
            _createSampleData(),
          animate: false,
        ),

      ),
    );
  }



  static List<charts.Series<MoodPerDay, DateTime>> _createSampleData() {
    final data = [
      new MoodPerDay(new DateTime(2017, 8, 19), 20),
      new MoodPerDay(new DateTime(2017, 8, 20), 40),
      new MoodPerDay(new DateTime(2017, 8, 21), 60),
      new MoodPerDay(new DateTime(2017, 8, 22), 40),
      new MoodPerDay(new DateTime(2017, 9, 19), 20),
      new MoodPerDay(new DateTime(2017, 9, 20), 40),
      new MoodPerDay(new DateTime(2017, 9, 21), 60),
      new MoodPerDay(new DateTime(2017, 9, 22), 40),

    ];

    return [
      new charts.Series<MoodPerDay, DateTime>(
        id: "Stimmung",
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (MoodPerDay mood, _) => mood.day,
        measureFn: (MoodPerDay mood, _) => mood.mood,
        data: data,
      )
    ];
  }
}

class MoodPerDay {
  final DateTime day;
  final int mood;

  MoodPerDay(this.day, this.mood);
}
