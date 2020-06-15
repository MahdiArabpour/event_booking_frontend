
import 'package:event_booking/src/ui/pages/auth_page/bloc/auth_toggle_bloc/bloc.dart';
import 'package:event_booking/src/ui/pages/auth_page/bloc/submit_bloc/bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import './src/usecases/login.dart';
import './src/usecases/signup.dart';
import './src/data/models/user.dart';
import './src/data/models/event.dart';
import './core/utils/ui/validator.dart';
import './src/data/datasources/graphql.dart';
import './src/data/repositories/event_booking_repository_impl.dart';

GetIt locator = GetIt.instance;

const graphqlServerUrl = 'https://event-booking-graphql.herokuapp.com/graphql';

void setupLocator() {
  locator.registerFactory(() => User());
  locator.registerFactory(() => Event());
  locator.registerLazySingleton(
      () => GraphQlImpl(client: locator(), url: graphqlServerUrl));
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => EventBookingRepositoryImpl(graphQl: locator<GraphQlImpl>()));
  locator.registerLazySingleton(() => SignUp(repository: locator<EventBookingRepositoryImpl>()));
  locator.registerLazySingleton(() => Login(repository: locator<EventBookingRepositoryImpl>()));
  locator.registerLazySingleton(() => Validator());
  locator.registerLazySingleton(() => AppBar());
  locator.registerLazySingleton(() => FlutterSecureStorage());
  locator.registerLazySingleton(() => ToggleBloc());
  locator.registerLazySingleton(() => SubmitBloc(
    signUp: locator(),
    login: locator(),
    secureStorage: locator(),
  ));
}
