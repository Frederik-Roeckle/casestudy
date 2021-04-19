import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/Lockscreen/PasscodeService.dart';
import 'package:flutter_app_casestudy/models/userr.dart';
import 'package:flutter_app_casestudy/services/database.dart';
import 'package:flutter_app_casestudy/styles.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentEmail;
  String _currentPhone;
  String _currentDoctor;
  String _passcode;
  TimeOfDay _reminderTime;

  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Ihre Einstellungen',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name:",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      initialValue: userData.name,
                      decoration: Styles.textInputDecoration
                          .copyWith(hintText: "Ihr Name"),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "E-Mail:",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      initialValue: userData.email,
                      decoration: Styles.textInputDecoration
                          .copyWith(hintText: "Ihre E-Mail Adresse"),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter an email' : null,
                      onChanged: (val) => setState(() => _currentEmail = val),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Mobilnummer:",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      initialValue: userData.phone,
                      decoration: Styles.textInputDecoration
                          .copyWith(hintText: "Ihre Telefonnummer"),
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a phone Number' : null,
                      onChanged: (val) => setState(() => _currentPhone = val),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ihre Praxis:",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      initialValue: userData.doctor,
                      decoration: Styles.textInputDecoration
                          .copyWith(hintText: "Ihre Praxis"),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentDoctor = val),
                    ),
                    SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ihr Passwort",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    TextFormField(
                      decoration: Styles.textInputDecoration
                          .copyWith(hintText: "Passcode"),
                      obscureText: true,
                      onChanged: (val) => setState(() => _passcode = val),
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      child: Text(
                      'Stimmungsabfrage Erinnerung',
                      style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        _reminderTime = await showTimePicker(context: context, initialTime: new TimeOfDay(hour: 8, minute: 0));
                      } ,),


                    SizedBox(height: 10.0),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                      //color: Colors.pink[400],
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if(_reminderTime != null) {
                          Workmanager().cancelByUniqueName("Stimmungsabfrage");
                          Workmanager().registerPeriodicTask("Stimmungsabfrage", "stimmungsabfrage", inputData: <String, dynamic>{'array': [_reminderTime.hour, _reminderTime.minute]});
                        }

                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentEmail ?? userData.email,
                            _currentPhone ?? userData.phone,
                            _currentDoctor ?? userData.doctor,
                          );
                        }
                        if(_passcode != null) {
                          var passcodeService = PasscodeService();
                          await passcodeService.initPasscodeService();
                          passcodeService.setPasscode(_passcode);
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Datenbank nicht erreichbar!'),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
