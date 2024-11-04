import 'package:http/http.dart' as http;
import 'package:rtdev/env/env_variables.dart';
import 'package:rtdev/types/model.dart';

class AppDel {
  static Future<bool> model(Model model) async {
    final url = Uri.http(EnvVariables.API_URL,
        '/models/${model.getModelName().toLowerCase()}/${model.id}');
    final res = await http.delete(url);
    return 200 <= res.statusCode && res.statusCode < 300;
  }
}
