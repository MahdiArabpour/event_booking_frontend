import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import './event.dart';

class User extends Equatable{
  final String id;
  final String email;
  final String password;
  final List<Event> createdEvents;

  User({
    @required this.id,
    @required this.email,
    this.password,
    this.createdEvents = const [],
  }) : super([
    id,
    email,
    password,
    createdEvents
  ]);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
    );
  }
}
