import 'package:meta/meta.dart';

import './event.dart';

class User {
  final String id;
  final String email;
  final String password;
  final List<Event> createdEvents;

  User(this.createdEvents, {
    @required this.id,
    @required this.email,
    @required this.password,
  });
}
