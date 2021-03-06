import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final double height;

  const Button({
    Key key,
    @required this.onTap,
    @required this.child,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = const BorderRadius.all(Radius.circular(30.0));
    return Material(
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        highlightColor: Colors.transparent,
        child: Ink(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: Theme.of(context).primaryColor,
          ),
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
