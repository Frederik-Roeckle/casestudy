import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/shared/loading.dart';
import 'package:flutter_app_casestudy/styles.dart';

class PhysiotherapieKraft extends StatefulWidget {
  PhysiotherapieKraft({Key key, this.titel}) : super(key: key);

  final String titel;

  @override
  _PhysiotherapieKraftState createState() => new _PhysiotherapieKraftState();
}

class _PhysiotherapieKraftState extends State<PhysiotherapieKraft> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Kraftübungen", style: Styles.headerLarge),
        backgroundColor: Styles.appBarColor,
      ),
      body: ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future getPhysio() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection('physioKraft').get();

    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          post: post,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getPhysio(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(snapshot.data[index]['titel']),
                  onTap: () => navigateToDetail(snapshot.data[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.post["titel"], style: Styles.headerLarge),
          backgroundColor: Styles.appBarColor),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ausführung:",
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Text(widget.post["ausfuehrung"]),
            padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
          ),
          SizedBox(height: 20.0),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ausgangsposition:",
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Text(widget.post["ausgangsposition"]),
            padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
          ),
        ],
      ),
    );
  }
}
