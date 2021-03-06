import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool autoFocus;
  final TextInputAction textInputAction;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final double height;
  final Function onTap;
  final Function validator;
  final bool isPassword;

  const TextInput({
    Key key,
    this.controller,
    this.hintText = '',
    this.autoFocus = false,
    this.textInputAction,
    this.onSubmitted,
    this.focusNode,
    this.height,
    this.onTap,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          textInputAction: textInputAction,
          onFieldSubmitted: onSubmitted,
          autofocus: autoFocus,
          focusNode: focusNode,
          validator: validator,
          onTap: onTap,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
