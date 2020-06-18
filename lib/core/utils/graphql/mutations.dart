import 'package:meta/meta.dart';

String signUp(String email, String password) =>
    'mutation{createUser(userInput:{email:"$email",password:"$password"}){_id,email}}';

String createEvent({
  @required String title,
  @required String description,
  @required double price,
  @required String dateISOString,
}) =>
    'mutation{createEvent(eventInput:{title:"$title",description:"$description",price:$price,date:"$dateISOString"}){_id,creator{email}}}';

String bookEvent(String eventId) =>
    'mutation{bookEvent(eventId:"$eventId"){_id,createdAt,updatedAt}}';

String cancelBooking(String bookingId) =>
    'mutation{cancelBooking(bookingId: "$bookingId"){_id}}';
