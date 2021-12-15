import 'package:fluro/fluro.dart';
import 'package:frontend_ascendere_platform/ui/views/views_docente/my_postulaciones_view.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/router/router.dart';

import 'package:frontend_ascendere_platform/providers/auth_provider.dart';
import 'package:frontend_ascendere_platform/providers/sidemenu_provider.dart';

import 'package:frontend_ascendere_platform/ui/views/views_docente/network_docente_view.dart';
import 'package:frontend_ascendere_platform/ui/views/views_docente/postulacion._view.dart';
import 'package:frontend_ascendere_platform/ui/views/views_docente/last_convocatoria_view.dart';
import 'package:frontend_ascendere_platform/ui/views/login_view.dart';

class DashboardDocentesHandlers {
  static Handler convocatoriaLast = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.convocatoriasLastRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const LastConvocatoriasView();
    } else {
      return const LoginView();
    }
  });

  static Handler postular = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.postularRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const PostulacionView();
    } else {
      return const LoginView();
    }
  });

  static Handler networkDocente = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.networkDocente);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const NetworkView();
    } else {
      return const LoginView();
    }
  });

  static Handler myPostulaciones = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl(Flurorouter.mypostulacionesRoute);

    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const MyPostulacionView();
    } else {
      return const LoginView();
    }
  });
}
