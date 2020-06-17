abstract class LocalDataSourceRepository {
  /// Encrypts the input token and saves encrypted token in local storage
  Future<void> saveToken(String token);
  /// Loads encrypted token and returns decrypted token
  Future<String> loadToken();
  /// deletes the saved token from internal storage for logging users out.
  Future<void> deleteToken();

  /// Saves the themeName in local storage
  Future<void> setDefaultTheme(String themeName);
  /// Loads previously saved theme.
  Future<String> loadDefaultTheme();
}