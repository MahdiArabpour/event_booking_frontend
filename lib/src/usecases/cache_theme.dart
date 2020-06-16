import 'package:meta/meta.dart';

import '../repositories/local_data_source_repository.dart';

class CacheTheme {
  final LocalDataSourceRepository repository;

  CacheTheme({@required this.repository});

  Future<void> call(String themeName) => repository.setDefaultTheme(themeName);

  Future<String> get() => repository.loadDefaultTheme();
}
