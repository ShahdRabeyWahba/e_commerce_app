import 'dart:ui';
import 'package:fluttertoast/fluttertoast.dart';

class AppFlutterToast {
  static Future<bool?> showToast({
    required String msg,
    required Color backgroundColor,
    required Color textColor,
    double fontSize = 16.0,
  }) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}

