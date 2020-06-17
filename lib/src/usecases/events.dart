import 'package:meta/meta.dart';

import '../data/models/event.dart';
import '../repositories/remote_data_source_repository.dart';

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
