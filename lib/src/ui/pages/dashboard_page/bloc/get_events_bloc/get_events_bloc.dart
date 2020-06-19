import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:event_booking/src/data/models/event.dart';
import 'package:meta/meta.dart';
import 'package:event_booking/core/errors/exceptions.dart';
import 'package:event_booking/src/usecases/events.dart';

import './bloc.dart';

class GetEventsBloc extends Bloc<GetEventsEvent, GetEventsState> {
  final Events events;

  GetEventsBloc({@required this.events});

  @override
  GetEventsState get initialState {
    return InitialGetEventsState();
  }

  @override
  Stream<GetEventsState> mapEventToState(GetEventsEvent event) async* {
    yield Loading();
    if (event is GetEvents) {
      yield* _tryGetEvents();
    }
  }

  Stream<GetEventsState> _tryGetEvents() async* {
    try {
      final List<Event> eventsList = await events.getEvents();
      yield Loaded(eventsList);
    } on NoInternetConnectionException {
      yield NoInternet();
    } on UnknownServerException {
      yield UnknownError();
    } on Exception {
      yield UnknownError();
    }
  }
}
