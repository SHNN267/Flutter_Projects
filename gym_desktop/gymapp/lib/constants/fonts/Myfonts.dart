import 'package:flutter/material.dart';

class MyFontStyle {
  static TextStyle mainTitle({Color? color}) {
    return TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black, // ✅ default handled here
      letterSpacing: 0.8,
    );
  }

  static TextStyle subTitle({Color? color}) {
    return TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black,
      letterSpacing: 0.8,
    );
  }

  static TextStyle normal({Color? color}) {
    return TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: color ?? Colors.black, // ✅ default handled here
      letterSpacing: 0.8,
    );
  }
}
