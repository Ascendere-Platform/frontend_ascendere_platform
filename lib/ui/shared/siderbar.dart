import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/router/router.dart';

import 'package:frontend_ascendere_platform/providers/sidemenu_provider.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';

import 'package:frontend_ascendere_platform/ui/shared/widgets/logo_ascendere.dart';
import 'package:frontend_ascendere_platform/ui/shared/widgets/menu_item.dart';
import 'package:frontend_ascendere_platform/ui/shared/widgets/text_separator.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({Key? key}) : super(key: key);

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
      // color: Colors.red,
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
                Flurorouter.createConvocatoriasRoute,
            text: 'Nueva',
            icon: Icons.playlist_add,
            onPressed: () => navigateTo(Flurorouter.createConvocatoriasRoute),
          ),
          // MenuItem(
          //   // isActive:
          //   //     sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
          //   text: 'Revisar',
          //   icon: Icons.playlist_add_check,
          //   onPressed: () {},
          // ),
          MenuItem(
            text: 'Publicar',
            icon: Icons.send,
            isActive:
                sideMenuProvider.currentPage == Flurorouter.convocatoriasRoute,
            onPressed: () => navigateTo(Flurorouter.convocatoriasRoute),
          ),
          // MenuItem(
          //   isActive:
          //       sideMenuProvider.currentPage == Flurorouter.convocatoriasRoute,
          //   text: 'Todas',
          //   icon: Icons.folder_open,
          //   onPressed: () => navigateTo(Flurorouter.convocatoriasRoute),
          // ),

          const SizedBox(height: 30),
          const TextSeparator(text: 'Recursos'),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.resourceRoute,
            text: 'Gestionar Recursos',
            icon: Icons.playlist_add,
            onPressed: () => navigateTo(Flurorouter.resourceRoute),
          ),
          // MenuItem(
          //     text: 'Pedidos Pendientes',
          //     icon: Icons.list_alt_sharp,
          //     isActive: false,
          //     onPressed: () {}),
          // MenuItem(
          //     text: 'Solcitar Recursos',
          //     icon: Icons.person_add,
          //     isActive: false,
          //     onPressed: () {}),

          const SizedBox(height: 30),
          const TextSeparator(text: 'Docentes'),
          MenuItem(
            // isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
            text: 'Red de Docentes',
            icon: Icons.sentiment_satisfied_alt,
            onPressed: () {},
          ),
          const SizedBox(height: 50),
          // const Spacer(),
          const TextSeparator(text: 'Administrador'),
          MenuItem(
            isActive: sideMenuProvider.currentPage == Flurorouter.usersRoute,
            text: 'Gestionar Usuarios',
            icon: Icons.supervised_user_circle,
            onPressed: () => navigateTo(Flurorouter.usersRoute),
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Color(0xFFFFFFFF),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
