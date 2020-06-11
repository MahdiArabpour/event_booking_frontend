import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializers.dart';
import './user.dart';

part 'generated_files/event.g.dart';

abstract class Event implements Built<Event, EventBuilder> {
  String get id;

  String get title;

  String get description;

  double get price;

  DateTime get date;

  User get creator;

  Event._();

  static Serializer<Event> get serializer => _$eventSerializer;

  factory Event([updates(EventBuilder b)]) = _$Event;

  factory Event.fromJson(Map<String, dynamic> map) =>
      serializers.deserializeWith(Event.serializer, map);

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(Event.serializer, this);
}
