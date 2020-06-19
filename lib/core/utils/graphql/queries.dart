import '../../errors/exceptions.dart';

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
    if (creator) "creator{email}",
  ];

  if (fields.isEmpty)
    throw EmptyQueryException('getEvent() query must have at least 1 argument');

  return 'query{events{${fields.join(',')}}}';
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

  return 'query{bookings{${fields.join(',')}}}';
}
