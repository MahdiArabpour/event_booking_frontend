import 'package:flutter/material.dart';

import '../../../../../core/utils/ui/page_size.dart';

class SignUpTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageSize = PageSize(context);
    return Container(
      padding: EdgeInsets.only(
        left: 20.0,
        top: 8.0,
        right: 15.0,
        bottom: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35.0),
          bottomRight: Radius.circular(35.0),
        ),
        color: Theme.of(context).accentColor,
      ),
      child: Text(
        'Event Booking',
        style: TextStyle(
            color: Theme.of(context).backgroundColor,
            fontSize: pageSize.deviceWidth * 0.11,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
