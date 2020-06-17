import 'package:flutter/material.dart';

import '../../core/utils/ui/ui_messages.dart';
import '../ui/pages/auth_page/auth_page.dart';
import './cache_token.dart';

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

    Toast toast = Toast();
    toast.show("Your're logged out");
  }
}
