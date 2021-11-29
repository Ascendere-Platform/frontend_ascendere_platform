import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/providers/options_avatar_provider.dart';
import 'package:frontend_ascendere_platform/providers/sidemenu_provider.dart';

import 'package:frontend_ascendere_platform/ui/shared/navbar.dart';
import 'package:frontend_ascendere_platform/ui/shared/siderbar.dart';
import 'package:frontend_ascendere_platform/ui/shared/widgets/options_avatar.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SideMenuProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    OptionsAvatarProvider.menuController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF9F9FB),
        body: Stack(
          children: [
            Row(
              children: [
                if (size.width >= 700) const Sidebar(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const NavBar(),
                      // View
                      Expanded(
                        child: widget.child,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AnimatedBuilder(
              animation: OptionsAvatarProvider.menuController,
              builder: (context, _) => Stack(
                children: [
                  if (OptionsAvatarProvider.isOpen)
                    Opacity(
                      opacity: OptionsAvatarProvider.opacity.value,
                      child: GestureDetector(
                        onHorizontalDragEnd: (DragEndDetails details) {
                          if (details.primaryVelocity! > 0.0) {
                            OptionsAvatarProvider.closeMenu();
                          }
                        },
                        onTap: () => OptionsAvatarProvider.closeMenu(),
                        child: Container(
                          width: size.width,
                          height: size.height,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 100),
                    right: OptionsAvatarProvider.isOpen ? 28.0 : -212.0,
                    top: 72.0,
                    child: const OptionsAvatar(),
                  ),
                ],
              ),
            ),
            if (size.width < 700)
              AnimatedBuilder(
                animation: SideMenuProvider.menuController,
                builder: (context, _) => Stack(
                  children: [
                    if (SideMenuProvider.isOpen)
                      Opacity(
                        opacity: SideMenuProvider.opacity.value,
                        child: GestureDetector(
                          onHorizontalDragEnd: (DragEndDetails details) {
                            if (details.primaryVelocity! < 0.0) {
                              SideMenuProvider.closeMenu();
                            }
                          },
                          onTap: () => SideMenuProvider.closeMenu(),
                          child: Container(
                            width: size.width,
                            height: size.height,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    Transform.translate(
                      offset: Offset(SideMenuProvider.movement.value, 0),
                      child: const Sidebar(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
