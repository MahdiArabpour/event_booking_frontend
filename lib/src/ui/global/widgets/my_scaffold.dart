import 'package:event_booking/core/utils/page_size.dart';
import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final Widget appBar;

  const MyScaffold({
    Key key,
    this.child,
    this.appBar,
  }) : super(key: key);

  final borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(15.0),
    topRight: Radius.circular(15.0),
  );

  @override
  Widget build(BuildContext context) {
    final pageSize = PageSize(context);
    return Scaffold(
      appBar: appBar,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          height: pageSize.bodyHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: borderRadius,
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: child,
          ),
        ),
      ),
    );
  }
}
