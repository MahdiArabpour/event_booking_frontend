import 'package:meta/meta.dart';

import '../datasources/local_storage.dart';
import '../../repositories/local_data_source_repository.dart';

class LocalDataSourceRepositoryImpl implements LocalDataSourceRepository {
  static const ACCESS_TOKEN = "ACCESS_TOKEN";
  static const THEME_NAME = "THEME_NAME";

  final Storage storage;
  final SecureStorage secureStorage;

  LocalDataSourceRepositoryImpl({
    @required this.storage,
    @required this.secureStorage,
  });

  @override
  Future<void> saveToken(String token) async =>
      await secureStorage.save(ACCESS_TOKEN, token);

  @override
  Future<String> loadToken() async => await secureStorage.load(ACCESS_TOKEN);


  @override
  Future<void> deleteToken() async => await secureStorage.delete(ACCESS_TOKEN);

  @override
  Future<void> setDefaultTheme(String themeName) async =>
      await storage.save(THEME_NAME, themeName);

  @override
  Future<String> loadDefaultTheme() async => await storage.load(THEME_NAME);

}
