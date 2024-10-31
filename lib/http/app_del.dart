import 'package:http/http.dart' as http;
import 'package:room_track_developerap/env/env_variables.dart';

class AppDel {
  static Future<String?> model(
      String modelName, Map<String, String> object) async {
    /* final url = Uri.http(EnvVariables.API_URL, '/interface/search', {
      'Content-Type': 'application/json',
      'name': byName,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    }); */
    return 'Delete Test Success!';
  }
}
