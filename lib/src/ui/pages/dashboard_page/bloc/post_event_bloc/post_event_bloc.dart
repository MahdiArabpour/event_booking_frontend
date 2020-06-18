import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/data/models/event.dart';
import 'package:event_booking/src/usecases/cache_token.dart';
import 'package:event_booking/src/usecases/events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

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
    } on AuthenticationException {
      yield AuthenticationFailed();
      await cacheToken.delete();
    } on NoInternetConnectionException {
      yield NoInternet();
    } on UnknownServerException {
      yield UnknownError();
    } on Exception {
      yield UnknownError();
    }
  }
}
