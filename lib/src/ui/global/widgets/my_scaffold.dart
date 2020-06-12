import 'package:flutter/material.dart';

import '../../../../core/utils/ui/page_size.dart';


class MyScaffold extends StatelessWidget {
  final Widget body;
  final Widget appBarTitle;
  final List<Widget> appBarActions;
  final Widget appBarLeading;

  MyScaffold({
    Key key,
    this.body,
    this.appBarTitle,
    this.appBarActions,
    this.appBarLeading,
  }) : super(key: key);

  final borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(15.0),
    topRight: Radius.circular(15.0),
  );

  @override
  Widget build(BuildContext context) {
    final pageSize = PageSize(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus(); // Dismiss keyboard on touch outside of tappable widgets.
      },
      child: Scaffold(
        appBar: AppBar(
          actions: appBarActions,
          leading: appBarLeading,
          title: appBarTitle,
          centerTitle: true,
          elevation: 0.0,
        ),
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
              child: body,
            ),
          ),
        ),
      ),
    );
  }
}
