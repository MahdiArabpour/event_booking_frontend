import 'package:meta/meta.dart';

import '../data/models/event.dart';
import '../../core/errors/exceptions.dart';
import '../repositories/remote_data_source_repository.dart';

class Events {
  final RemoteDataSourceRepository repository;

  Events({@required this.repository});

  Future<List<Event>> getEvents() async {
    return await repository.getEvents();
  }

  Future<Event> postEvent(Event event, String token) async {
    try {
      return await repository.postEvent(event, token: token);
    } on PostEventException catch (errors) {
      final messages = errors.messages;

      final thereIsAMessage = messages != null && messages.length >= 1;

      if (thereIsAMessage && messages.first == ServerErrorMessages.AUTH_FAILED)
        throw AuthenticationException();

      throw UnknownServerException();
    }
  }
}
