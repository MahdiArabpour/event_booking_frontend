import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookEventState extends Equatable {}

class InitialBookEventState extends BookEventState {
  @override
  List<Object> get props => [];
}

class Loading extends BookEventState {
  @override
  List<Object> get props => [];
}

class Booked extends BookEventState {
  @override
  List<Object> get props => [];
}

class UnBooked extends BookEventState {
  @override
  List<Object> get props => [];
}

class AuthenticationFailed extends BookEventState{
  @override
  List<Object> get props => [];
}

class NoInternet extends BookEventState {
  @override
  List<Object> get props => [];
}

class UnknownError extends BookEventState {
  @override
  List<Object> get props => [];
}