import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/auth_provider.dart';

import 'package:frontend_ascendere_platform/ui/views/login_view.dart';
import 'package:frontend_ascendere_platform/ui/views/register_view.dart';
import 'package:frontend_ascendere_platform/ui/views/dashboard_view.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const LoginView();
    } else {
      return const DashboardView();
    }
  });
  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.notAuthenticated) {
      return const RegisterView();
    } else {
      return const DashboardView();
    }
  });
}