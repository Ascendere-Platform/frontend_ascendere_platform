import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/api/micro_users.dart';

import 'package:frontend_ascendere_platform/models/http/profile.dart';
import 'package:frontend_ascendere_platform/models/user.dart';
import 'package:frontend_ascendere_platform/services/local_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProfileProvider extends ChangeNotifier {
  Profile? profile;

  getProfile() async {
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(LocalStorage.prefs.getString('token') ?? '');
    final user = User.fromMap(decodedToken);

    final resp = await MicroUsers.getProfile("/verperfil", user.id);

    profile = Profile.fromJson(resp);

    notifyListeners();
  }
}
