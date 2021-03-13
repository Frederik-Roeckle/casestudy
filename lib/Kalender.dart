import 'styles.dart';
import 'package:flutter/material.dart';

class Kalender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Kalender", style: Styles.headerLarge),
            backgroundColor: Styles.appBarColor),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ));
  }
}
