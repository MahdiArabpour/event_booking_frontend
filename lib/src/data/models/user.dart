import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializers.dart';
import './event.dart';

part 'generated_files/user.g.dart';

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

  factory User.fromJson(Map<String, dynamic> jsonData) {
    Map<String, dynamic> map = {
      ...jsonData,
      'id': jsonData['_id'],
      '_id': null,
    };
    return serializers.deserializeWith(User.serializer, map);
  }

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(User.serializer, this);
}
