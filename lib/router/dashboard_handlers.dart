import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/auth_provider.dart';
import 'package:frontend_ascendere_platform/ui/views/dashboard_view.dart';
import 'package:frontend_ascendere_platform/ui/views/login_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });
}
