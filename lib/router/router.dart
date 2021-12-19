import 'package:fluro/fluro.dart';

import 'package:frontend_ascendere_platform/router/admin_handlers.dart';
import 'package:frontend_ascendere_platform/router/dashboard_docentes_handlers.dart';
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
  static String convocatoriaRoute = '/dashboard/convocatorias/:uid';
  static String createConvocatoriasRoute = '/dashboard/create_convocatorias';

  static String resourceRoute = '/dashboard/resources';

  static String usersRoute = '/dashboard/users';

  static String usersSettingsRoute = '/dashboard/user-settings';

  static String postulacionesRoute = '/dashboard/postulaciones';
  static String postulacionRoute = '/dashboard/postulaciones/:uid';
  static String projectsRoute = '/dashboard/projects';

  // Dashboard Docentes
  static String convocatoriasLastRoute =
      '/dashboard/docentes/convocatoria-vigente';
  static String postularRoute = '/dashboard/docentes/postular';
  static String mypostulacionesRoute = '/dashboard/docentes/mis-postualciones';
  static String networkDocente = '/dashboard/docentes/red-docentes';

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
    router.define(createConvocatoriasRoute,
        handler: DashboardHandlers.createConvocatorias,
        transitionType: TransitionType.fadeIn);

    router.define(convocatoriaRoute,
        handler: DashboardHandlers.convocatoria,
        transitionType: TransitionType.fadeIn);

    router.define(usersRoute,
        handler: DashboardHandlers.users,
        transitionType: TransitionType.fadeIn);

    router.define(resourceRoute,
        handler: DashboardHandlers.resources,
        transitionType: TransitionType.fadeIn);

    router.define(usersSettingsRoute,
        handler: DashboardHandlers.usersSettings,
        transitionType: TransitionType.fadeIn);

    router.define(postulacionesRoute,
        handler: DashboardHandlers.postulaciones,
        transitionType: TransitionType.fadeIn);

    router.define(postulacionRoute,
        handler: DashboardHandlers.postulacion,
        transitionType: TransitionType.fadeIn);

    router.define(projectsRoute,
        handler: DashboardHandlers.projects,
        transitionType: TransitionType.fadeIn);

    // Dashboard Docentes
    router.define(convocatoriasLastRoute,
        handler: DashboardDocentesHandlers.convocatoriaLast,
        transitionType: TransitionType.fadeIn);

    router.define(postularRoute,
        handler: DashboardDocentesHandlers.postular,
        transitionType: TransitionType.fadeIn);

    router.define(networkDocente,
        handler: DashboardDocentesHandlers.networkDocente,
        transitionType: TransitionType.fadeIn);

    router.define(mypostulacionesRoute,
        handler: DashboardDocentesHandlers.myPostulaciones,
        transitionType: TransitionType.fadeIn);

    // No page Found
    router.notFoundHandler = NoPageFoundHandlers.noPageFound;
  }
}
