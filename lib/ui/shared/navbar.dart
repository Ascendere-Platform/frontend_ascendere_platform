import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_ascendere_platform/providers/auth_provider.dart';
import 'package:frontend_ascendere_platform/providers/sidemenu_provider.dart';

import 'package:frontend_ascendere_platform/ui/buttons/custom_icon_button.dart';
import 'package:frontend_ascendere_platform/ui/shared/widgets/avatar_icon.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.transparent,
      height: 50,
      child: Row(
        children: [
          // SideMenu
          if (size.width <= 700)
            CustomIconButton(
              onPressed: () {
                SideMenuProvider.openMenu();
              },
              icon: Icons.sort,
              isDark: true,
            ),
          const Spacer(),

          // Options Perfile
          CustomIconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
            icon: Icons.exit_to_app_outlined,
          ),
          const SizedBox(width: 12),
          CustomIconButton(
            onPressed: () {},
            icon: Icons.notifications_rounded,
          ),
          const SizedBox(width: 12),
          const AvatarIcon(),
          const SizedBox(width: 12),
        ],
      ),
    );
  }
}
