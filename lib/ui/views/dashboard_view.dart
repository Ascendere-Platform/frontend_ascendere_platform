import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:frontend_ascendere_platform/providers/auth_provider.dart';

import 'package:frontend_ascendere_platform/models/user.dart';

import 'package:frontend_ascendere_platform/services/local_storage.dart';

import 'package:frontend_ascendere_platform/ui/buttons/link_text.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(LocalStorage.prefs.getString('token') ?? '');
    final user = User.fromMap(decodedToken);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(user.email),
          LinkText(
            text: 'Cerrar Sesión',
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
