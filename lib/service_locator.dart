import 'package:event_booking/src/data/datasources/local_storage.dart';
import 'package:event_booking/src/data/repositories/local_data_source_repository_impl.dart';
import 'package:event_booking/src/ui/global/theme/app_themes.dart';
import 'package:event_booking/src/ui/global/theme/bloc/bloc.dart';
import 'package:event_booking/src/ui/pages/auth_page/bloc/auth_toggle_bloc/bloc.dart';
import 'package:event_booking/src/ui/pages/auth_page/bloc/submit_bloc/bloc.dart';
import 'package:event_booking/src/usecases/cache_theme.dart';
import 'package:event_booking/src/usecases/cache_token.dart';
import 'package:event_booking/src/usecases/events.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import './src/usecases/login.dart';
import './src/usecases/signup.dart';
import './core/utils/ui/validator.dart';
import './src/data/datasources/graphql.dart';
import './src/data/repositories/remote_data_source_repository_impl.dart';

GetIt locator = GetIt.instance;

const graphqlServerUrl = 'https://event-booking-graphql.herokuapp.com/graphql';

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => AppBar());
  locator.registerLazySingleton(() => Validator());
  locator.registerLazySingleton(() => ToggleBloc());
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => FlutterSecureStorage());
  locator.registerLazySingleton(() => CacheTheme(repository: locator<LocalDataSourceRepositoryImpl>()));
  locator.registerLazySingleton(() => CacheToken(repository: locator<LocalDataSourceRepositoryImpl>()));
  locator.registerLazySingleton(() => Storage(sharedPreferences: locator<SharedPreferences>()));
  locator.registerLazySingleton(() => SecureStorage(secureStorage: locator<FlutterSecureStorage>()));
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => GraphQlImpl(client: locator(), url: graphqlServerUrl));
  locator.registerLazySingleton(() => Login(repository: locator<RemoteDataSourceRepositoryImpl>()));
  locator.registerLazySingleton(() => SignUp(repository: locator<RemoteDataSourceRepositoryImpl>()));
  locator.registerLazySingleton(() => Events(repository: locator<RemoteDataSourceRepositoryImpl>()));
  locator.registerLazySingleton(() => RemoteDataSourceRepositoryImpl(graphQl: locator<GraphQlImpl>()));
  locator.registerLazySingleton(() => SubmitBloc(signUp: locator(), login: locator(), cacheToken: locator()));
  locator.registerLazySingleton(() => LocalDataSourceRepositoryImpl(secureStorage: locator<SecureStorage>(), storage: locator<Storage>()));
  final defaultTheme = await loadDefaultTheme();
  locator.registerLazySingleton(() => ThemeState(theme: defaultTheme));
  locator.registerLazySingleton(() => ThemeBloc(cacheTheme: locator(), initialThemeState: locator<ThemeState>()));
}
