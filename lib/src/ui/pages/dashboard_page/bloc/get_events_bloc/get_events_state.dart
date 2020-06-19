import 'package:equatable/equatable.dart';
import 'package:event_booking/src/data/models/event.dart';

abstract class GetEventsState extends Equatable{}

class InitialGetEventsState extends GetEventsState {
  @override
  List<Object> get props => [];
}

class Loading extends GetEventsState {
  @override
  List<Object> get props => [];
}

class Loaded extends GetEventsState {

  final List<Event> events;

  Loaded(this.events);

  @override
  List<Object> get props => [events];
}

class NoInternet extends GetEventsState {
  @override
  List<Object> get props => [];
}

class UnknownError extends GetEventsState {
  @override
  List<Object> get props => [];
}