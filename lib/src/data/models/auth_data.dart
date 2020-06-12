import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import './serializers.dart';

part 'auth_data.g.dart';

abstract class AuthData implements Built<AuthData, AuthDataBuilder> {
  String get userId;

  String get token;

  int get tokenExpiration;

  static Serializer<AuthData> get serializer => _$authDataSerializer;

  AuthData._();

  factory AuthData([updates(AuthDataBuilder b)]) = _$AuthData;

  factory AuthData.fromJson(Map<String, dynamic> jsonData) {
    return serializers.deserializeWith(AuthData.serializer, jsonData);
  }

  Map<String, dynamic> toJson() =>
      serializers.serializeWith(AuthData.serializer, this);
}
