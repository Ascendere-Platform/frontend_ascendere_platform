import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:frontend_ascendere_platform/services/local_storage.dart';

class MicroPostulaciones {
  static Future post(String path, Map<String, dynamic> data) async {
    http.Response response = await http.post(
      Uri.parse('http://137.184.244.204/$path'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error en el POST');
    }
  }

  static Future get(String path) async {
    http.Response response = await http.get(
      Uri.parse('http://137.184.244.204/$path'),
      headers: {
        'Authorization': 'Bearer ${LocalStorage.prefs.getString('token')}',
      },
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error en el POST');
    }
  }

  static Future put(String path) async {
    http.Response response = await http.put(
      Uri.parse('http://137.184.244.204/$path'),
      headers: {
        'Authorization': 'Bearer ${LocalStorage.prefs.getString('token')}',
      },
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error en el PUT');
    }
  }

  static Future putData(String path, Map<String, dynamic> data) async {
    http.Response response = await http.put(
      Uri.parse('http://137.184.244.204/$path'),
      headers: {
        'Authorization': 'Bearer ${LocalStorage.prefs.getString('token')}',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error en el PUT');
    }
  }
}
