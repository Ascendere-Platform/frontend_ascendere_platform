import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:frontend_ascendere_platform/api/micro_users.dart';
import 'package:frontend_ascendere_platform/models/http/profile.dart';

class UsersProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<Profile> users = [];
  List<Rol> rol = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnIndex;

  String? idRol;

  UsersProvider() {
    getPaginatedUsers();
    getRol();
  }

  getPaginatedUsers() async {
    String resp = await MicroUsers.get('/listaUsuarios?type=new&page=1');
    List<dynamic> list = json.decode(resp);
    users.clear();

    for (var user in list) {
      users.add(Profile.fromMap(user));
    }

    isLoading = false;

    notifyListeners();
  }

  getRol() async {
    String resp = await MicroUsers.get('/listaRoles');
    List<dynamic> list = json.decode(resp);

    for (var user in list) {
      rol.add(Rol.fromMap(user));
    }

    isLoading = false;

    notifyListeners();
  }

  void sort<T>(Comparable<T> Function(Profile user) getField) {
    users.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });

    ascending = !ascending;

    notifyListeners();
  }

  void refresUser(Profile newUser) {
    users = users.map((user) {
      if (user.id != newUser.id) return user;
      user = newUser;
      return user;
    }).toList();

    notifyListeners();
  }

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  updateRol(String id, String? idRol) async {
    try {
      await MicroUsers.put('/modificarRol?iduser=$id&idrol=$idRol');
      getPaginatedUsers();
      notifyListeners();
    } catch (e) {
      throw 'Error al actualizar el rol del usuario';
    }

    notifyListeners();
  }
}
