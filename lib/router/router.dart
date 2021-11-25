import 'package:fluro/fluro.dart';

import 'package:frontend_ascendere_platform/router/admin_handlers.dart';
import 'package:frontend_ascendere_platform/router/dashboard_handlers.dart';
import 'package:frontend_ascendere_platform/router/no_page_found_handlers.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = '/';

  // Auth Router
  static String loginRoute = '/auth/login';
  static String registerRoute = '/auth/register';

  // Dashboard
  static String dashboardRoute = '/dashboard';

  static String convocatoriasRoute = '/dashboard/convocatorias';

  static String usersRoute = '/dashboard/users';

  static void configureRoutes() {
    // Auth Routes
    router.define(rootRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(loginRoute,
        handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute,
        handler: AdminHandlers.register, transitionType: TransitionType.none);

    // Dashboard
    router.define(dashboardRoute,
        handler: DashboardHandlers.dashboard,
        transitionType: TransitionType.fadeIn);
    router.define(convocatoriasRoute,
        handler: DashboardHandlers.convocatorias,
        transitionType: TransitionType.fadeIn);
    router.define(usersRoute,
        handler: DashboardHandlers.users,
        transitionType: TransitionType.fadeIn);

    // No page Found
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
