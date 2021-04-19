import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/services/auth.dart';
import 'package:flutter_app_casestudy/shared/loading.dart';
import 'package:flutter_app_casestudy/styles.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field states
  String email = '';
  String password = '';
  String error = '';

//Beim Registrieren wird ein neuer User in Firebase angelegt
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Styles.STRONG_GREEN,
            appBar: AppBar(
              backgroundColor: Styles.STRONG_GREEN,
              elevation: 0.0,
              title: Text('Sign Up', style: Styles.headerLarge),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: Styles.WHITE,
                  ),
                  //Ermöglicht Wechsel zur RegisterPage
                  label: Text('Sign In', style: Styles.textDefault),
                  onPressed: () => widget.toggleView(),
                ),
              ],
            ),
            body: ListView(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: Styles.textInputDecoration
                              .copyWith(hintText: 'E-Mail'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter an email' : null,
                          onChanged: (val) {
                            //Hinterlegt die E-Mail in einer Variable
                            setState(() => email = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        TextFormField(
                          decoration: Styles.textInputDecoration
                              .copyWith(hintText: 'Password'),
                          obscureText: true,
                          validator: (val) => val.length < 6
                              ? 'Enter a password 6+ chars long'
                              : null,
                          //Hinterlegt das Passwort in einer Varaible
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            //Die Parameter E-Mail und Passwort werden mitgegeben
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
                                        email, password);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                    loading = false;
                                  });
                                }
                              }
                            }),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
