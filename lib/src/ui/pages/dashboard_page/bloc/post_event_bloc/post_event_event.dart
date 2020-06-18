import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:event_booking/src/data/models/event.dart';

abstract class PostEventEvent extends Equatable {}

class PostEvent extends PostEventEvent {
  final Event event;
  final String token;

  PostEvent({
    @required this.event,
    @required this.token,
  });

  @override
  List<Object> get props => [event];
}
