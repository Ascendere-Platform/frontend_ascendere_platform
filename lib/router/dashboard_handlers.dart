import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/router/router.dart';

import 'package:frontend_ascendere_platform/providers/sidemenu_provider.dart';
import 'package:frontend_ascendere_platform/providers/auth_provider.dart';

import 'package:frontend_ascendere_platform/ui/views/projects_approved_view.dart';
import 'package:frontend_ascendere_platform/ui/views/users_view.dart';
import 'package:frontend_ascendere_platform/ui/views/postulacion_info_view.dart';
import 'package:frontend_ascendere_platform/ui/views/postulaciones_view.dart';
import 'package:frontend_ascendere_platform/ui/views/info_user.dart';
import 'package:frontend_ascendere_platform/ui/views/create_convocatoria_view.dart';
import 'package:frontend_ascendere_platform/ui/views/dashboard_view.dart';
import 'package:frontend_ascendere_platform/ui/views/login_view.dart';
import 'package:frontend_ascendere_platform/ui/views/convocatoria_view.dart';
import 'package:frontend_ascendere_platform/ui/views/convocatorias_view.dart';
import 'package:frontend_ascendere_platform/ui/views/resources_view.dart';

class DashboardHandlers {
  static Handler dashboard = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.dashboardRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    } else {
      return const LoginView();
    }
  });

  static Handler convocatorias = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.convocatoriasRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ConvocatoriasView();
    } else {
      return const LoginView();
    }
  });

  static Handler createConvocatorias = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.createConvocatoriasRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const CreateConvocatoriaView();
    } else {
      return const LoginView();
    }
  });

  static Handler convocatoria = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.convocatoriaRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['uid']?.first != null) {
        return ConvocatoriaView(cid: params['uid']!.first);
      } else {
        return const ConvocatoriasView();
      }
    } else {
      return const LoginView();
    }
  });

  static Handler users = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const UsersView();
    } else {
      return const LoginView();
    }
  });

  static Handler resources = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.resourceRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ResourcesView();
    } else {
      return const LoginView();
    }
  });

  static Handler usersSettings = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.usersSettingsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const InfoUserView();
    } else {
      return const LoginView();
    }
  });

  static Handler postulaciones = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.postulacionesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PostulacionesView();
    } else {
      return const LoginView();
    }
  });

  static Handler postulacion = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.postulacionRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params['uid']?.first != null) {
        return PostualcionInfoView(id: params['uid']!.first);
      } else {
        return const PostulacionesView();
      }
    } else {
      return const LoginView();
    }
  });

  static Handler projects = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.projectsRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const ProjectsApprovedView();
    } else {
      return const LoginView();
    }
  });
}
