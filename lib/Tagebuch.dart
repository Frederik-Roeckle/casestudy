import 'styles.dart';
import 'package:flutter/material.dart';

class Tagebuch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Tagebuch", style: Styles.headerLarge),
            backgroundColor: Styles.appBarColor),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ));
  }
}
