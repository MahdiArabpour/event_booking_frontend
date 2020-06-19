import 'package:flutter/material.dart';

import './cache_token.dart';
import '../ui/pages/auth_page/auth_page.dart';

class Logout {
  final CacheToken cachedToken;

  Logout({
    @required this.cachedToken,
  });

  Future<void> call(BuildContext context) async {
    await cachedToken.delete();

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => AuthPage(),
    ));
  }
}