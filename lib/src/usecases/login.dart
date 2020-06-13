import 'package:event_booking/src/data/models/auth_data.dart';
import 'package:event_booking/src/repositories/event_booking_repository.dart';
import 'package:meta/meta.dart';

class Login {
  final EventBookingRepository repository;

  Login({@required this.repository});

  Future<AuthData> call(String email, String password) async {
    throw UnimplementedError();
  }
}
