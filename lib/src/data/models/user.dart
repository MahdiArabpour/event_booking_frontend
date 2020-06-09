import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializers.dart';
import './event.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  String get id;

  String get email;

  @nullable
  String get password;

  @nullable
  BuiltList<Event> get createdEvents;

  User._();

  static Serializer<User> get serializer => _$userSerializer;

  factory User([updates(UserBuilder b)]) = _$User;

  factory User.fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(User.serializer, map);

  String toJson() =>
      json.encode(serializers.serializeWith(User.serializer, this));
}