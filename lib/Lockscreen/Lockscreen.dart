import 'package:flutter/cupertino.dart';

class Lockscreen extends StatefulWidget {
  @override
  _LockscreenController createState() => _LockscreenController();
}

class _LockscreenController extends State<Lockscreen> {
  @override
  Widget build(BuildContext context) => _LockscreenView(this);
}

class _LockscreenView extends StatelessWidget {

  final _LockscreenController state;
  const _LockscreenView(this.state, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

}
