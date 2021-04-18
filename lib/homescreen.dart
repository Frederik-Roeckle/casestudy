import 'package:flutter_app_casestudy/screens/home/settings_form.dart';
import 'package:flutter_app_casestudy/services/auth.dart';
import 'styles.dart';
import 'package:flutter/material.dart';

class HomescreenList extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.85,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
        isScrollControlled: true,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Übersicht", style: Styles.headerLarge),
        backgroundColor: Styles.STRONG_GREEN,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person, color: Styles.WHITE),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Styles.WHITE),
            onPressed: () => _showSettingPanel(),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: [
                _routingTile(context, 'Kalender', '/Kalender'),
                _routingTile(context, 'Physiotherapie', '/Physiotherapie'),
                _routingTile(context, 'Tagebuch', '/Tagebuch'),
                _routingTile(context, 'Stimmung', '/Stimmung'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _routingTile(context, String funktion, String route) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        child: Container(
          padding: EdgeInsets.all(30.0),
          decoration: BoxDecoration(
              color: Styles.STRONG_GREEN,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: new TextButton(
              onPressed: () => Navigator.pushNamed(context, route),
              child: new Text(funktion, style: Styles.textDefault)),
        ));
  }
}
