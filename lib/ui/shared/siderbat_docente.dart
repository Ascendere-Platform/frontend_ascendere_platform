import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/router/router.dart';

import 'package:frontend_ascendere_platform/providers/sidemenu_provider.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';

import 'package:frontend_ascendere_platform/ui/shared/widgets/logo_ascendere.dart';
import 'package:frontend_ascendere_platform/ui/shared/widgets/menu_item.dart';
import 'package:frontend_ascendere_platform/ui/shared/widgets/text_separator.dart';

class SidebarDocente extends StatelessWidget {
  const SidebarDocente({Key? key}) : super(key: key);

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 212,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const AscendereLogo(),
          MenuItem(
            isActive:
                sideMenuProvider.currentPage == Flurorouter.dashboardRoute,
            text: 'Panel de control',
            icon: Icons.dashboard,
            onPressed: () => navigateTo(Flurorouter.dashboardRoute),
          ),
          const SizedBox(height: 22),
          const TextSeparator(text: 'Convocatorias'),
          MenuItem(
            isActive: sideMenuProvider.currentPage ==
                Flurorouter.convocatoriasLastRoute,
            text: 'Convocatoria Vigente',
            icon: Icons.article,
            onPressed: () => navigateTo(Flurorouter.convocatoriasLastRoute),
          ),
          const SizedBox(height: 30),
          const TextSeparator(text: 'Proyectos'),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.postularRoute,
            text: 'Postular',
            icon: Icons.add,
            onPressed: () => navigateTo(Flurorouter.postularRoute),
          ),
          MenuItem(
            isActive: sideMenuProvider.currentPage ==
                Flurorouter.mypostulacionesRoute,
            text: 'Mis postulaciones',
            icon: Icons.list,
            onPressed: () => navigateTo(Flurorouter.mypostulacionesRoute),
          ),
          const SizedBox(height: 30),
          const TextSeparator(text: 'Docentes'),
          MenuItem(
            isActive:
                sideMenuProvider.currentPage == Flurorouter.networkDocente,
            text: 'Red de Docentes',
            icon: Icons.sentiment_satisfied_alt,
            onPressed: () => navigateTo(Flurorouter.networkDocente),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Color(0xFFFFFFFF),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
