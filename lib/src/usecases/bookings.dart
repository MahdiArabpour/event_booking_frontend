import 'package:event_booking/core/errors/exceptions.dart';
import 'package:meta/meta.dart';

import 'package:event_booking/src/repositories/remote_data_source_repository.dart';

class Bookings {

  final RemoteDataSourceRepository repository;

  Bookings({@required this.repository});


  Future<String> bookEvent(String eventId, {@required String token}) async {
    try{
      return await repository.bookEvent(eventId, token: token);
    } on BookEventException catch (errors) {
      final messages = errors.messages;

      final thereIsAMessage = messages != null && messages.length >= 1;

      if (thereIsAMessage && messages.first == ServerErrorMessages.AUTH_FAILED)
        throw AuthenticationException();

      throw UnknownServerException();
    }
  }

  Future<void> unBookEvent(String bookingId, {@required String token}) async {

  }
}
