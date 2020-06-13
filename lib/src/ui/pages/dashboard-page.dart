import 'package:event_booking/src/ui/global/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBarTitle: Text('Event Booking'),
      body: Center(
        child: Container(child: Text('Hello World')),
      ),
    );
  }
}
