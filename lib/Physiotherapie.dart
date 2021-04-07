import 'styles.dart';
import 'package:flutter/material.dart';

class Physiotherapie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Physiotherapie", style: Styles.HEADER_LARGE),
            backgroundColor: Styles.APP_BAR_COLOR),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [],
        ));
  }
}
