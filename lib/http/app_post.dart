import 'package:http/http.dart' as http;
import 'package:room_track_developerap/env/env_variables.dart';

class AppPost {
  static Future<String?> model(
      String modelName, Map<String, String> object) async {
    for (final entrie in object.entries) {
      if (entrie.value.isEmpty && entrie.key != "ref" && entrie.key != "img") {
        return "\"${entrie.key}\" field cant be empty";
      }
    }
    /* final url = Uri.http(EnvVariables.API_URL, '/interface/search', {
      'Content-Type': 'application/json',
      'name': byName,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    }); */
    return 'Post Test Success!';
  }
}
