import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';

import 'src/app.dart';
import 'service_locator.dart';
import 'src/ui/pages/dashboard-page.dart';
import 'src/ui/pages/auth_page/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  final flutterSecureStorage = locator<FlutterSecureStorage>();
  Widget launcherPage;
  final token = await flutterSecureStorage.read(key: "access_token");
  if (token == null)
    launcherPage = AuthPage();
  else
    launcherPage = DashboardPage();
  runApp(App(launcherPage));
}
