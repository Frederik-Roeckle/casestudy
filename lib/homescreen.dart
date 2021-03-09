import 'package:flutter_app_casestudy/Kategorien.dart';

import 'styles.dart';
import 'package:flutter/material.dart';

class HomescreenList extends StatelessWidget {
  final List<Kategorien> kategorien;

  HomescreenList(this.kategorien);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Übersicht")),
      body: ListView.builder(
        itemCount: this.kategorien.length,
        itemBuilder: _listViewItemBuilder,
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var kategorien = this.kategorien[index];
    return ListTile(
        contentPadding: EdgeInsets.all(10.0),
        title: Text(kategorien.name),
        onTap: () => _navigationToKategorieDetail(context, kategorien));
  }

  void _navigationToKategorieDetail(
      BuildContext context, Kategorien kategorie) {
    Navigator.pushNamed(context, kategorie.route);
  }
}
