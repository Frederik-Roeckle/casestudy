import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/shared/loading.dart';
import 'package:flutter_app_casestudy/styles.dart';

class Physiotherapie extends StatefulWidget {
  @override
  _PhysiotherapieState createState() => new _PhysiotherapieState();
}

class _PhysiotherapieState extends State<Physiotherapie> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Physiotherapie", style: Styles.headerLarge),
        backgroundColor: Styles.appBarColor,
      ),
      body: PhysioList(),
    );
  }
}

class PhysioList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: FirebaseFirestore.instance.collection('physio').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return Loading();
        return new ListView(
          children: snapshot.data.docs.map((document) {
            return new ListTile(
              title: new Text(document['titel']),
              subtitle: new Text(document['ausfuehrung']),
            );
          }).toList(),
        );
      },
    );
  }
}
