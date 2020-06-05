import 'package:flutter/material.dart';

void main() => runApp(EventBookingApp());

class EventBookingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Booking',
      home: Scaffold(
        appBar: AppBar(
          title: Text('EventBooking'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
