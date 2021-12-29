import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:frontend_ascendere_platform/services/local_storage.dart';

import '_token_wso2.dart';

class MicroConvocatorias {
  static const url = 'http://159.203.68.218:8280/micro-convocatorias/v1';

  static Future post(String path, Map<String, dynamic> data) async {
    http.Response response = await http.post(
      Uri.parse('$url$path'),
      headers: {
        'TokenApp': 'Bearer ${Constants.apiKeyWSO2}',
        'Authorization': 'Bearer ${LocalStorage.prefs.getString('token')}',
      },
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
      Uri.parse('$url$path'),
      headers: {
        'TokenApp': 'Bearer ${Constants.apiKeyWSO2}',
        'Authorization': 'Bearer ${LocalStorage.prefs.getString('token')}',
      },
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error en el GET');
    }
  }

  static Future put(String path, Map<String, dynamic> data) async {
    http.Response response = await http.put(
      Uri.parse('$url$path'),
      headers: {
        'TokenApp': 'Bearer ${Constants.apiKeyWSO2}',
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
