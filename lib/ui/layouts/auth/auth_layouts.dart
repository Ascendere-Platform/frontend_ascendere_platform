import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/ui/layouts/auth/widgets/background_image.dart';
import 'package:frontend_ascendere_platform/ui/layouts/auth/widgets/custom_title.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Scrollbar(
        child: SafeArea(
          child: ListView(
            children: [
              (size.width > 1000)
                  ? _DesktopBody(child: child)
                  : _MobileBody(child: child),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.black,
      child: Row(children: [
        // Image Background
        const Expanded(child: BackgroundImage()),
        // View Container
        Container(
          width: 600,
          height: double.infinity,
          color: Colors.black,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CustomTitle(),
              const SizedBox(height: 50),
              Expanded(child: child),
            ],
          ),
        ),
      ]),
    );
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const CustomTitle(),
          SizedBox(
            height: 600,
            child: child,
          ),
          const SizedBox(
            width: double.infinity,
            height: 400,
            child: BackgroundImage(),
          )
        ],
      ),
    );
  }
}
