import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import './event.dart';
import './user.dart';

part 'generated_files/serializers.g.dart';

@SerializersFor(const [
  User,
  Event,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
