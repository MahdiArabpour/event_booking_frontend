import 'package:equatable/equatable.dart';

import '../../../../../data/models/event.dart';

abstract class PostEventState extends Equatable{}

class InitialState extends PostEventState{
  @override
  List<Object> get props => [];
}

class Loading extends PostEventState{
  @override
  List<Object> get props => [];
}

class EventAdded extends PostEventState{
  final Event event;

  EventAdded(this.event);

  @override
  List<Object> get props => [event];
}

class AuthenticationFailed extends PostEventState{
  @override
  List<Object> get props => [];
}

class NoInternet extends PostEventState{
  @override
  List<Object> get props => [];
}

class UnknownError extends PostEventState{
  @override
  List<Object> get props => [];
}
