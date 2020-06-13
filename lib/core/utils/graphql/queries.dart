import 'package:event_booking/core/errors/exceptions.dart';

String login(String email, String password) =>
    'query{login(email:"$email", password:"$password"){userId,token,tokenExpiration}}';

String getEvents({
  bool id = false,
  bool title = false,
  bool description = false,
  bool price = false,
  bool date = false,
  bool creator = false,
}) {
  final fields = [
    if (id) "_id",
    if (title) "title",
    if (description) "description",
    if (price) "price",
    if (date) "date",
    if (creator) "creator{_id}",
  ];

  if (fields.isEmpty)
    throw EmptyQueryException('getEvent() query must have at least 1 argument');

  return 'query{events{${_generateFieldsString(fields)}}}';
}

String getBookings({
  bool id = false,
  bool event = false,
  bool user = false,
  bool createdAt = false,
  bool updatedAt = false,
}) {
  final fields = [
    if (id) "_id",
    if (event) "event{_id}",
    if (user) "user{_id}",
    if (createdAt) "createdAt",
    if (updatedAt) "updatedAt",
  ];

  if (fields.isEmpty)
    throw EmptyQueryException(
        'getBookings() query must have at least 1 argument');

  return 'query{bookings{${_generateFieldsString(fields)}}}';
}

String _generateFieldsString(List<String> fields) {
  final fieldsBuffer = StringBuffer();

  for (var i = 0; i < fields.length; i++) {
    fieldsBuffer.write(fields[i]);
    if (i != fields.length - 1) fieldsBuffer.write(',');
  }

  return '$fieldsBuffer';
}
