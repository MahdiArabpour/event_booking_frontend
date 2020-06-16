import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class LocalStorage {
  /// saves given string in local storage
  Future<void> save(String name, String value);

  /// encrypts given string and saves it in local storage
  Future<String> load(String name);
}

class Storage implements LocalStorage {
  final SharedPreferences sharedPreferences;

  Storage({
    @required this.sharedPreferences,
  });

  @override
  Future<String> load(String name) async => sharedPreferences.getString(name);

  @override
  Future<void> save(String name, String value) async => await sharedPreferences.setString(name, value);
}

class SecureStorage implements LocalStorage {
  final FlutterSecureStorage secureStorage;

  SecureStorage({
    @required this.secureStorage,
  });

  @override
  Future<String> load(String name) async => await secureStorage.read(key: name);

  @override
  Future<void> save(String name, String value) async => await secureStorage.write(key: name, value: value);
}
