import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 40.0;
  static const _textSizeDefault = 20.0;
  static final Color _textColorStrong = _hexToColor('FFFFFF');
  static final Color _textColorDefault = _hexToColor('FFFFFF');
  static final Color tileColor = Color(0xff64B6AC);
  static final Color appBarColor = Color(0xff0C1B33);
  static final Color STRONG_GREEN = Color(0xFF00B050);
  static final Color LIGHT_GREEN = Color(0xFF00CC5C);
  static final Color WHITE = Color(0xFFFCFCFF);
  static final Color LIGHT_GREY = Color(0xFFA6A6A6);
  static final Color STRONG_GREY = Color(0xFF7C7C7C);
  static final String _fontNameDefault = 'Bahnschrift';

  static final navBarTitle = TextStyle(fontFamily: _fontNameDefault);

  static final headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorStrong,
  );
  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }
}
