import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import './src/data/models/user.dart';
import './src/data/datasources/graphql.dart';
import './src/data/models/event.dart';
import './src/data/usecases/signup.dart';

GetIt locator = GetIt.instance;

const graphqlServerUrl = 'https://event-booking-graphql.herokuapp.com/graphql';

void setupLocator() {
  locator.registerFactory(() => User());
  locator.registerFactory(() => Event());
  locator.registerLazySingleton(
      () => GraphQlImpl(client: locator(), url: graphqlServerUrl));
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => SignUp(graphQl: locator<GraphQlImpl>()));
}
