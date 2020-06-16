import 'package:event_booking/src/data/models/event.dart';
import 'package:event_booking/src/repositories/remote_data_source_repository.dart';
import 'package:meta/meta.dart';

class Events {
  final RemoteDataSourceRepository repository;

  Events({@required this.repository});

  Future<List<Event>> getEvents() {
    return repository.getEvents();
  }

  Future<Event> postEvent(Event event){
    return repository.postEvent(event);
  }
}
