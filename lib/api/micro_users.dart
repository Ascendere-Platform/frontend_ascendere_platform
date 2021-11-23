import 'dart:convert';

import 'package:http/http.dart' as http;

class MicroUsers {
  static Future post(String path, Map<String, dynamic> data) async {
    http.Response response = await http.post(
      Uri.parse('http://34.123.95.33/$path'),
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error en el POST');
    }
  }
}
