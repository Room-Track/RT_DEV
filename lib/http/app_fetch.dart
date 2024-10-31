import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:room_track_developerap/env/env_variables.dart';

class AppFetch {
  /* static Future<Iterable<BasicInfoType>> basicInfoIterable(
      String byName) async {
    final String token =
        (await FirebaseAuth.instance.currentUser?.getIdToken())!;
    final url = Uri.http(EnvVariables.API_URL, '/interface/search', {
      'name': byName,
    });
    final res = await http.get(url, headers: {
      'authorization': token,
    });
    final body = jsonDecode(res.body);
    if (200 <= res.statusCode && res.statusCode < 300) {
      final List raw = body['data'];
      return raw.map((json) {
        final iSearch = ISearch.fromJSON(json);
        return BasicInfoType.fromISearch(iSearch);
      });
    }
    return [];
  } */

  static Future<List<Map<String, dynamic>>> modelArr(
      String modelName, String filter, String query) async {
    final url = Uri.http(EnvVariables.API_URL, '/${modelName.toLowerCase()}s/', {
      filter: query,
    });
    final res = await http.get(url);
    final body = jsonDecode(res.body);
    if (200 <= res.statusCode && res.statusCode < 300) {
      return List.from(body['data']);
    }
    return [];
  }
}
