import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/router/router.dart';

import 'package:frontend_ascendere_platform/providers/auth_provider.dart';

import 'package:frontend_ascendere_platform/services/local_storage.dart';
import 'package:frontend_ascendere_platform/services/navigation_service.dart';
import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/ui/layouts/auth/auth_layouts.dart';
import 'package:frontend_ascendere_platform/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:frontend_ascendere_platform/ui/layouts/splash/splash_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  Flurorouter.configureRoutes();
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ascendere Platform',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
      navigatorKey: NavigationService.navigationKey,
      scaffoldMessengerKey: NotificationsService.messengerKey,
      builder: (_, child) {
        final authProvider = Provider.of<AuthProvider>(context);

        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }

        if (authProvider.authStatus == AuthStatus.authenticated) {
          return DashboardLayout(child: child!);
        } else {
          return AuthLayout(child: child!);
        }
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
            thumbColor:
                MaterialStateProperty.all(Colors.grey.withOpacity(0.5))),
      ),
    );
  }
}
