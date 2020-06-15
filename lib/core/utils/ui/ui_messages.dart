import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;

class Toast {
  void show(
    String text, {
    ToastLength length,
  }) {
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
      gravity: toast.ToastGravity.BOTTOM,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
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
    this.color,
  });

  void show(String text) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: Theme.of(context).textTheme.caption,
      ),
      backgroundColor: color,
    ));
  }
}
