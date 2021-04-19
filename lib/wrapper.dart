import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/homescreen.dart';
import 'package:flutter_app_casestudy/models/userr.dart';
import 'package:flutter_app_casestudy/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);

    // Bei Erfolgreicher Anmeldung wird man auf den Homescreen weiter geleitet, ansonsten zur Authentication (SignIn der Registrierung)
    if (user == null) {
      return Authenticate();
    } else {
      return HomescreenList();
    }
  }
}
