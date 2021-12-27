import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/models/http/state_response.dart';
import 'package:frontend_ascendere_platform/services/notifications_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:frontend_ascendere_platform/api/micro_users.dart';

import 'package:frontend_ascendere_platform/services/local_storage.dart';

import 'package:frontend_ascendere_platform/models/http/profile.dart';
import 'package:frontend_ascendere_platform/models/user.dart';

class ProfileProvider extends ChangeNotifier {
  Profile? profile;
  bool? hasFollow;

  ProfileProvider() {
    getProfile();
  }

  getProfile() async {
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(LocalStorage.prefs.getString('token') ?? '');
    final user = User.fromMap(decodedToken);

    final resp = await MicroUsers.getProfile("/verperfil", user.id);

    profile = Profile.fromJson(resp);

    notifyListeners();
    return profile;
  }

  followDocente(String id) async {
    // final data = {"email": "2test@ejemplo.com", "password": "123456"};
    try {
      MicroUsers.follow('/seguirUsuario?id=$id').then((resp) {
        NotificationsService.showSnackbar('Siguiendo a nuevo docente');
        return true;
      }).catchError((e) {
        NotificationsService.showSnackbarError(
            'No puede seguir al docente, $e');
        return false;
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  hasFollowDocente(String id) async {
    try {
      final resp = await MicroUsers.get('/consultoRelacion?id=$id');
      hasFollow = Status.fromJson(resp).status;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
