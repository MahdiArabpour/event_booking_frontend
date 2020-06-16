import 'package:meta/meta.dart';

import '../repositories/local_data_source_repository.dart';

class CacheToken{
  final LocalDataSourceRepository repository;

  CacheToken({@required this.repository});

  Future<void> call(String token) => repository.saveToken(token);

  Future<String> get() => repository.loadToken();
}