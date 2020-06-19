import 'package:event_booking/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../../../../usecases/events.dart';
import '../../../../../data/models/event.dart';
import '../get_events_bloc/get_events_bloc.dart';
import '../../../../../usecases/cache_token.dart';
import '../get_events_bloc/get_events_event.dart';
import '../../../../../../core/errors/exceptions.dart';

class PostEventBloc extends Bloc<PostEventEvent, PostEventState> {
  final Events events;
  final CacheToken cacheToken;

  PostEventBloc({
    @required this.events,
    @required this.cacheToken,
  });

  @override
  PostEventState get initialState => InitialState();

  @override
  Stream<PostEventState> mapEventToState(PostEventEvent event) async* {
    if (event is PostEvent) {
      yield Loading();
      yield* _tryPostEvent(event.event, event.token);
    }
  }

  Stream<PostEventState> _tryPostEvent(Event event, String token) async* {
    try {
      final addedEvent = await events.postEvent(event, token);
      yield EventAdded(addedEvent);
      locator<GetEventsBloc>().add(GetEvents());
    } on AuthenticationException {
      await cacheToken.delete();
      yield AuthenticationFailed();
    } on NoInternetConnectionException {
      yield NoInternet();
    } on UnknownServerException {
      yield UnknownError();
    } on Exception {
      yield UnknownError();
    }
  }
}
