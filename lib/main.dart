import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/router/router.dart';

import 'package:frontend_ascendere_platform/providers/resources_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/profile_provider.dart';
import 'package:frontend_ascendere_platform/providers/options_avatar_provider.dart';
import 'package:frontend_ascendere_platform/providers/sidemenu_provider.dart';
import 'package:frontend_ascendere_platform/providers/users_provider.dart';
import 'package:frontend_ascendere_platform/providers/auth_provider.dart';
import 'package:frontend_ascendere_platform/providers/resources_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/convocatoria_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/annexes_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/strategic_lines_form_provider.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/expected_result_form.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/rubric_form.dart';
import 'package:frontend_ascendere_platform/providers/convocatoria/types_project_form_provider.dart';

import 'package:frontend_ascendere_platform/models/user.dart';

import 'package:frontend_ascendere_platform/services/local_storage.dart';
import 'package:frontend_ascendere_platform/services/navigation_service.dart';
import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/ui/layouts/dashboard/dashboard_docente_layout.dart';
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
        ChangeNotifierProvider(lazy: false, create: (_) => SideMenuProvider()),
        ChangeNotifierProvider(
            lazy: false, create: (_) => OptionsAvatarProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => UsersProvider()),
        ChangeNotifierProvider(create: (_) => ResourcesProvider()),
        ChangeNotifierProvider(create: (_) => ConvocatoriaProvider()),
        ChangeNotifierProvider(create: (_) => AnnexesFormProvider()),
        ChangeNotifierProvider(create: (_) => StrategicLinesFormProvider()),
        ChangeNotifierProvider(create: (_) => ExpectedResultFormProvider()),
        ChangeNotifierProvider(create: (_) => RubricFormProvider()),
        ChangeNotifierProvider(create: (_) => TypesProjectFormProvider()),
        ChangeNotifierProvider(create: (_) => ConvocatoriaFormProvider()),
        ChangeNotifierProvider(create: (_) => ResourcesFormProvider()),
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
          Map<String, dynamic> decodedToken =
              JwtDecoder.decode(LocalStorage.prefs.getString('token') ?? '');
          final user = User.fromMap(decodedToken);
          if (user.rol == 'admin') return DashboardLayout(child: child!);
          return DashboardDocenteLayout(child: child!);
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
