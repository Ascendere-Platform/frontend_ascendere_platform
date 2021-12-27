import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/api/micro_users.dart';

import 'package:frontend_ascendere_platform/router/router.dart';

import 'package:frontend_ascendere_platform/services/local_storage.dart';
import 'package:frontend_ascendere_platform/services/navigation_service.dart';
import 'package:frontend_ascendere_platform/services/notifications_service.dart';

import 'package:frontend_ascendere_platform/models/http/auth_response.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;

  AuthProvider() {
    isAuthenticated();
  }

  login(String email, String password) async {
    final data = {'email': email, 'password': password};

    MicroUsers.post('/login', data).then((resp) {
      authStatus = AuthStatus.authenticated;

      final authResponse = AuthResponse.fromJson(resp);

      LocalStorage.prefs.setString('token', authResponse.token);

      NavigationService.replaceTo(Flurorouter.dashboardRoute);

      notifyListeners();
    }).catchError((e) {
      NotificationsService.showSnackbarError(
          'Correo electrónico o Contraseña incorrectos');
    });
  }

  register(String email, password, name, lastName) async {
    final data = {
      'email': email,
      'password': password,
      'nombre': name,
      'apellidos': lastName,
    };
    MicroUsers.post('/registro', data).then((resp) {
      NotificationsService.showSnackbar(
          'Cuenta creada, ahora puede iniciar sesión con los datos ingresados');
      NavigationService.replaceTo(Flurorouter.loginRoute);
    }).catchError((e) {
      NotificationsService.showSnackbarError(
          'Cuenta no creada, ingrese nuevamente los datos');
    });
  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      authStatus = AuthStatus.authenticated;
      return true;
    } catch (e) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
