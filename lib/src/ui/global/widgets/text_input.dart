import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autoFocus;

  const TextInput({
    Key key,
    this.controller,
    this.hintText = '',
    this.autoFocus = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
