import 'package:event_booking/service_locator.dart';
import 'package:flutter/material.dart';

class PageSize {
  final BuildContext context;
  double deviceHeight;
  double deviceWidth;
  double topPadding;
  double appBar;
  double bodyHeight;

  PageSize(this.context) {
    final mediaQuery = MediaQuery.of(context);
    deviceHeight = mediaQuery.size.height;
    deviceWidth = mediaQuery.size.width;
    topPadding = mediaQuery.padding.top;
    final myAppBar = locator<AppBar>();
    appBar = myAppBar.preferredSize.height;
    bodyHeight = deviceHeight - topPadding - appBar;
  }
}
