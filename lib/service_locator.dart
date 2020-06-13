import 'package:event_booking/src/data/repositories/event_booking_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import './src/data/models/user.dart';
import './src/data/datasources/graphql.dart';
import './src/data/models/event.dart';
import './src/usecases/signup.dart';
import './core/utils/ui/validator.dart';

GetIt locator = GetIt.instance;

const graphqlServerUrl = 'https://event-booking-graphql.herokuapp.com/graphql';

void setupLocator() {
  locator.registerFactory(() => User());
  locator.registerFactory(() => Event());
  locator.registerLazySingleton(
      () => GraphQlImpl(client: locator(), url: graphqlServerUrl));
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => SignUp(graphQl: locator<GraphQlImpl>()));
  locator.registerLazySingleton(() => EventBookingRepositoryImpl(graphQl: locator<GraphQlImpl>()));
  locator.registerLazySingleton(() => Validator());
  locator.registerLazySingleton(() => AppBar());
}
