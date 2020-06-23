import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BookEventEvent extends Equatable {}

class BookEvent extends BookEventEvent {
  final String eventId;
  final String token;

  BookEvent({
    @required this.eventId,
    @required this.token,
  });

  @override
  List<Object> get props => [eventId];
}

class UnBookEvent extends BookEventEvent {
  final String bookingId;
  final String token;

  UnBookEvent({
    @required this.bookingId,
    @required this.token,
  });

  @override
  List<Object> get props => [bookingId];
}
