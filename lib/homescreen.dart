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
            height: MediaQuery.of(context).size.height * 0.75,
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
        backgroundColor: Styles.appBarColor,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          TextButton.icon(
            icon: Icon(Icons.settings),
            label: Text('settings'),
            onPressed: () => _showSettingPanel(),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _routingTile(context, 'Kalender', '/Kalender'),
          _routingTile(context, 'Physiotherapie', '/Physiotherapie'),
          _routingTile(context, 'Tagebuch', '/Tagebuch'),
          _routingTile(context, "MoodPoll", "/MoodPoll"),
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
