import 'package:event_booking/service_locator.dart';
import 'package:flutter/material.dart';

import './src/app.dart';
import './src/usecases/cache_token.dart';
import './src/ui/pages/auth_page/auth_page.dart';
import './src/ui/pages/dashboard_page/dashboard-page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator(); // register all of required instances to service locator
  final launcherPage = await _getLauncherPage();
  runApp(App(launcherPage));
}

Future<Widget> _getLauncherPage() async {
  final cacheToken = locator<CacheToken>();

  Widget launcherPage;
  final token = await cacheToken.get();

  if (token == null)
    launcherPage = AuthPage();
  else
    launcherPage = DashboardPage();

  return launcherPage;
}