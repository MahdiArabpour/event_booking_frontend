String signUp(String email, String password) =>
    'mutation{createUser(userInput:{email:"$email",password:"$password"}){_id,email}}';

String createEvent(
  String title,
  String description,
  double price,
  String dateISOString,
) =>
    'mutation{createEvent(eventInput:{title:"$title",description:"$description",price:$price,date:"$dateISOString"}){_id}}';

String bookEvent(String eventId) =>
    'mutation{bookEvent(eventId:"$eventId"){_id,createdAt,updatedAt}}';

String cancelBooking(String bookingId) =>
    'mutation{cancelBooking(bookingId: "$bookingId"){_id}}';
