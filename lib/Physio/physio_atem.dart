import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/shared/loading.dart';
import 'package:flutter_app_casestudy/styles.dart';

class PhysiotherapieAtem extends StatefulWidget {
  PhysiotherapieAtem({Key key, this.titel}) : super(key: key);

  final String titel;

  @override
  _PhysiotherapieAtemState createState() => new _PhysiotherapieAtemState();
}

class _PhysiotherapieAtemState extends State<PhysiotherapieAtem> {
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
      body: ListPageAtem(),
    );
  }
}

class ListPageAtem extends StatefulWidget {
  @override
  _ListPageAtemState createState() => _ListPageAtemState();
}

class _ListPageAtemState extends State<ListPageAtem> {
  Future getPhysioAtem() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestore.collection('physioAtem').get();

    return qn.docs;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPageAtem(
          post: post,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getPhysioAtem(),
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

class DetailPageAtem extends StatefulWidget {
  final DocumentSnapshot post;
  DetailPageAtem({this.post});

  @override
  _DetailPageAtemState createState() => _DetailPageAtemState();
}

class _DetailPageAtemState extends State<DetailPageAtem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.post["titel"], style: Styles.headerLarge),
          backgroundColor: Styles.appBarColor),
      body: Container(
        child: Card(
          child: ListTile(
            title: Text(widget.post["titel"]),
            subtitle: Text(widget.post["ablauf"]),
            //subtitle: Text(widget.post["platzhalter"]),
          ),
        ),
      ),
    );
  }
}
