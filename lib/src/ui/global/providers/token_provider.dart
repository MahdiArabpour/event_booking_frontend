import 'package:event_booking/service_locator.dart';
import 'package:flutter/material.dart';

import '../../../usecases/cache_token.dart';

class TokenProvider with ChangeNotifier{
  String _token;

  TokenProvider(){
    _loadToken();
  }

  String get token => _token;

  void setToken(String token){
    this._token = token;
    notifyListeners();
  }

  _loadToken() async {
    final cachedToken = locator<CacheToken>();
    final token = await cachedToken.get();
    setToken(token);
  }
}