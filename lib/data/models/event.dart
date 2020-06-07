import 'package:meta/meta.dart';

import './user.dart';

class Event {
  final String id;
  final String title;
  final String description;
  final double price;
  final DateTime date;
  final User creator;

  Event({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.date,
    @required this.creator,
  });
}
