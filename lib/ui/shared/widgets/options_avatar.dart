import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/auth_provider.dart';
import 'package:frontend_ascendere_platform/providers/profile_provider.dart';
import 'package:frontend_ascendere_platform/providers/sidemenu_provider.dart';

import 'package:frontend_ascendere_platform/services/navigation_service.dart';

import 'package:frontend_ascendere_platform/models/http/profile.dart';

import 'package:frontend_ascendere_platform/ui/shared/widgets/menu_option.dart';
import 'package:frontend_ascendere_platform/ui/shared/widgets/menu_item.dart';
import 'package:frontend_ascendere_platform/ui/shared/widgets/text_separator.dart';

class OptionsAvatar extends StatelessWidget {
  const OptionsAvatar({Key? key}) : super(key: key);

  void navigateTo(String routeName) {
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    final profile = profileProvider.profile;

    final profileTemp = (profile == null)
        ? Profile(
            rolid: "",
            nombre: "nombre",
            apellidos: "apellido",
            id: "",
            fechaNacimiento: DateTime.parse("1969-07-20 20:18:04Z"),
            email: "email",
            avatar: "avatar")
        : profile;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
      width: 212,
      height: 260,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          const TextSeparator(text: 'Datos del usuario'),
          MenuOption(
              text: profileTemp.nombre + ' ' + profileTemp.apellidos,
              onPressed: () {}),
          MenuItem(
            text: profileTemp.email,
            icon: Icons.email,
            onPressed: () {},
          ),
          const SizedBox(height: 22),
          const TextSeparator(text: 'Acciones'),
          MenuItem(
            // isActive:
            //     sideMenuProvider.currentPage == Flurorouter.categoriesRoute,
            text: 'Configuración',
            icon: Icons.settings,
            onPressed: () {},
          ),
          MenuItem(
            text: 'Cerrar Sesión',
            icon: Icons.exit_to_app_outlined,
            isActive: false,
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      color: const Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(5),
      boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
