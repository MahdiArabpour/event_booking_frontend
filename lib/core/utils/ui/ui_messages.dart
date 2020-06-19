import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

class Toast {
  void show(
    String text, {
    ToastLength length = ToastLength.LONG,
    Color color = Colors.black87,
    Gravity gravity = Gravity.BOTTOM,
  }) {
    toast.ToastGravity toastGravity;
    switch (gravity) {
      case Gravity.TOP:
        toastGravity = toast.ToastGravity.TOP;
        break;
      case Gravity.CENTER:
        toastGravity = toast.ToastGravity.CENTER;
        break;
      case Gravity.BOTTOM:
        toastGravity = toast.ToastGravity.BOTTOM;
        break;
    }

    toast.Toast toastLength;
    int timeInSecForIosWeb;
    if (length == ToastLength.SHORT) {
      toastLength = toast.Toast.LENGTH_SHORT;
      timeInSecForIosWeb = 1;
    } else {
      toastLength = toast.Toast.LENGTH_LONG;
      timeInSecForIosWeb = 3;
    }
    toast.Fluttertoast.showToast(
      msg: text,
      toastLength: toastLength,
      gravity: toastGravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

enum Gravity {
  TOP,
  CENTER,
  BOTTOM,
}

enum ToastLength {
  SHORT,
  LONG,
}

class MySnackBar {
  final BuildContext context;
  final Color color;

  MySnackBar({
    this.context,
    this.color = Colors.green,
  });

  void show(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      backgroundColor: color,
    ));
  }
}
