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
          // const SizedBox(height: 50),
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
            // isActive: sideMenuProvider.currentPage == Flurorouter.modifyRoute,
            text: 'Nueva',
            icon: Icons.playlist_add,
            onPressed: () {},
          ),
          MenuItem(
            // isActive:
            //     sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
            text: 'Revisar',
            icon: Icons.playlist_add_check,
            onPressed: () {},
          ),
          MenuItem(
              text: 'Publicar',
              icon: Icons.send,
              isActive: false,
              onPressed: () {}),
          MenuItem(
              text: 'Archivadas',
              icon: Icons.folder_open,
              isActive: false,
              onPressed: () {}),

          const SizedBox(height: 30),
          const TextSeparator(text: 'Recursos'),
          MenuItem(
            // isActive: sideMenuProvider.currentPage == Flurorouter.iconsRoute,
            text: 'Validar',
            icon: Icons.check,
            onPressed: () {},
          ),
          MenuItem(
              text: 'Revisar',
              icon: Icons.playlist_add_check,
              isActive: false,
              onPressed: () {}),
          MenuItem(
              text: 'Asignar Personal',
              icon: Icons.person_add,
              isActive: false,
              onPressed: () {}),
          MenuItem(
            // isActive: sideMenuProvider.currentPage == Flurorouter.blankRoute,
            text: 'Archivados',
            icon: Icons.folder_open,
            onPressed: () {},
          ),
          const SizedBox(height: 50),
          // const Spacer(),
          const TextSeparator(text: 'Administrador'),
          MenuItem(
              text: 'Gestionar Usuarios',
              icon: Icons.supervised_user_circle,
              onPressed: () {}),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Color(0xFFFFFFFF),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
