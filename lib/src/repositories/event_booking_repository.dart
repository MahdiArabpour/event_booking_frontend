import '../data/models/auth_data.dart';
import '../data/models/user.dart';

abstract class EventBookingRepository {
  /// Sends user information to the graphql server to create new user account
  /// and if signup was successful returns created [User] Object!
  Future<User> signup(String email, String password);

  /// Sends user information to the graphql server to check if user is
  /// signed up previously
  Future<AuthData> login(String email, String password);
}
