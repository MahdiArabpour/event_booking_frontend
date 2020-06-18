import 'package:meta/meta.dart';

import '../data/models/user.dart';
import '../data/models/event.dart';
import '../data/models/auth_data.dart';

abstract class RemoteDataSourceRepository {
  /// Sends user information to the graphql server to create new user account
  /// and if signup was successful returns created [User] Object!
  Future<User> signup(String email, String password);

  /// Sends user information to the graphql server to check if user is
  /// signed up previously
  Future<AuthData> login(String email, String password);


  /// gets all events and returns a list of event objects.
  Future<List<Event>> getEvents();

  Future<Event> postEvent(Event event, {@required String token});
}
