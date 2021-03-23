import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_casestudy/Lockscreen/PasscodeService.dart';
import 'package:flutter_app_casestudy/styles.dart';
import 'package:flutter_app_lock/flutter_app_lock.dart';

class Lockscreen extends StatefulWidget {
  @override
  _LockscreenController createState() => _LockscreenController();
}

class _LockscreenController extends State<Lockscreen> {
  @override
  Widget build(BuildContext context) => _LockscreenView(this);


  //Globale Variablen


  //Controller
  final passwdTextFieldController = TextEditingController();



  //Functions

  void checkForCorrectLoginPasscode(String value) async {
    var passcodeService = PasscodeService();
    await passcodeService.initPasscodeService();




    bool _passcodeCorrect = false;

    Future<bool> _res = passcodeService.checkPasscodeWithString(value);
     await _res.then((value) => _passcodeCorrect = value);


    if(_passcodeCorrect) {
      AppLock.of(context).didUnlock();
    } else {

    }
  }
}

class _LockscreenView extends StatelessWidget {

  final _LockscreenController state;
  const _LockscreenView(this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(50, 50, 50, 50),
          decoration: BoxDecoration(
          color: Styles.STRONG_GREEN
      ),
          child: ListView(
            children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage("assets/app_symbol.png"),
                ),
              ),
              Container(
                child: TextField(
                  controller: state.passwdTextFieldController,
                  onChanged: state.checkForCorrectLoginPasscode,
                  keyboardType: TextInputType.number,
                  showCursor: false,
                  decoration: InputDecoration(
                    labelText: "Passcode",
                    fillColor: Styles.LIGHT_GREY,
                    filled: true,
                    labelStyle: TextStyle(
                      color: Styles.LIGHT_GREEN
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Styles.LIGHT_GREEN
                      )
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Styles.LIGHT_GREEN
                      )
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Styles.LIGHT_GREEN
                      )
                    )
                  ),
                ),
              ),
              Container(
                child: RaisedButton(
                  child: Text(
                    "Log In",
                    style: Styles.textDefault,
                  ),
                  color: Styles.LIGHT_GREEN,
                  onPressed: () {
                    state.checkForCorrectLoginPasscode(state.passwdTextFieldController.text);
                  },
                ),
              ),
            ],
          )
      ),

    );
  }

}
