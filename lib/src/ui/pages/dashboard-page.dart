import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Booking'),
      ),
      body: Center(
        child: Container(child: Text(
           'Hello World')),
      ),
    );
  }
}
