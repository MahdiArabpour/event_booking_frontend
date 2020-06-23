import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import './bloc.dart';
import '../../../../../usecases/bookings.dart';
import '../../../../../usecases/cache_token.dart';
import '../../../../../../core/errors/exceptions.dart';

class BookEventBloc extends Bloc<BookEventEvent, BookEventState> {
  final Bookings bookings;
  final CacheToken cacheToken;

  BookEventBloc({
    @required this.bookings,
    @required this.cacheToken,
  });

  @override
  BookEventState get initialState => InitialBookEventState();

  @override
  Stream<BookEventState> mapEventToState(BookEventEvent event) async* {
    yield Loading();
    if (event is BookEvent)
      yield* _tryBookEvent(event.eventId, event.token);
    else if (event is UnBookEvent) yield* _tryUnBookEvent(event.bookingId, event.token);
  }

  Stream<BookEventState> _tryBookEvent(String eventId, String token) async* {
    try {
      await bookings.bookEvent(eventId, token: token);
      yield Booked();
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

  _tryUnBookEvent(String bookingId, String token) async* {
    try {
      bookings.unBookEvent(bookingId, token: token);
      yield UnBooked();
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
