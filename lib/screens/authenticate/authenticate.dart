import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/screens/authenticate/register.dart';
import 'package:flutter_app_casestudy/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

//Wechselt zwischen Register und SignIn Screen hin und her, wenn man auf den Button drueckt
class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
