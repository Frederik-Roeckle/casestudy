import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 40.0;
  static const _textSizeDefault = 20.0;
  static final Color _textColorStrong = _hexToColor('000000');
  static final Color _textColorDefault = _hexToColor('666666');
  static final Color tileColor = Color(0xff64B6AC);
  static final Color appBarColor = Color(0xff0C1B33);
  // static final String _fontNameDefault = 'Bahn...'

// static final navBarTitle = TextStyle(
//     fontFamily: _fontNameDefault,
//   );

  static final headerLarge = TextStyle(
    // fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorStrong,
  );
  static final textDefault = TextStyle(
    // fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
