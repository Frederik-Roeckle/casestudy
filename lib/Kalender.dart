import 'styles.dart';
import 'package:flutter/material.dart';

class Kalender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Kalender", style: Styles.HEADER_LARGE),
            backgroundColor: Styles.APP_BAR_COLOR),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ));
  }
}
