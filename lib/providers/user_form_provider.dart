import 'package:flutter/material.dart';
import 'package:frontend_ascendere_platform/api/micro_users.dart';
import 'package:frontend_ascendere_platform/models/http/profile.dart';
import 'package:frontend_ascendere_platform/services/notifications_service.dart';

class UserFormProvider extends ChangeNotifier {
  late GlobalKey<FormState> formKey;

  Profile? user;

  copyUserWith({
    String? avatar,
    String? banner,
    String? biografia,
    String? ubicacion,
    String? sitioWeb,
  }) {
    user = Profile(
      id: user!.id,
      rol: user!.rol,
      nombre: user!.nombre,
      email: user!.email,
      fechaNacimiento: user!.fechaNacimiento,
      avatar: avatar ?? user!.avatar,
      banner: banner ?? user!.banner,
      biografia: biografia ?? user!.biografia,
      ubicacion: ubicacion ?? user!.ubicacion,
      sitioWeb: sitioWeb ?? user!.sitioWeb,
    );
    notifyListeners();
  }

  bool validateForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser() async {
    if (!validateForm()) return false;

    final data = {
      "avatar": user!.avatar,
      "banner": user!.banner,
      "ubicacion": user!.ubicacion,
      "biografia": user!.biografia,
      "sitioWeb": user!.sitioWeb,
    };

    try {
      MicroUsers.putData('/modificarPerfil', data).then((resp) {
        NotificationsService.showSnackbar('Usuario actualizado');
        return true;
      }).catchError((e) {
        NotificationsService.showSnackbarError('Usuario no actualizada, $e');
        return false;
      });
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
