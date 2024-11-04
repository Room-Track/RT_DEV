import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rtdev/env/env_variables.dart';
import 'package:rtdev/types/model.dart';

class AppPost {
  static Future<bool> model(Model model) async {
    final url = Uri.http(
        EnvVariables.API_URL, '/models/${model.getModelName().toLowerCase()}/');
    final res = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: "{\"data\":${jsonEncode([model.toJson()])}}",
    );
    return 200 <= res.statusCode && res.statusCode < 300;
  }
}
