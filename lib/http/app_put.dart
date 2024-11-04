import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rtdev/env/env_variables.dart';
import 'package:rtdev/types/model.dart';

class AppPut {
  static Future<bool> model(
      Model model, MapEntry<String, String> entrie) async {
    final jsonMap = model.toJson();
    jsonMap.update(entrie.key, (val) => entrie.value);
    final url = Uri.http(EnvVariables.API_URL,
        '/models/${model.getModelName().toLowerCase()}/${model.id}');
    final res = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: "{\"data\":${jsonEncode([jsonMap])}}",
    );
    return 200 <= res.statusCode && res.statusCode < 300;
  }
}
