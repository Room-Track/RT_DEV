import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:rtdev/env/env_variables.dart';
import 'package:rtdev/types/model.dart';
import 'package:rtdev/types/models/indication.dart';
import 'package:rtdev/types/models/location.dart';

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

  static Future<Iterable<Indication>> linksOf(String name) async {
    final url =
        Uri.http(EnvVariables.API_URL, '/models/indication/linksof/$name');
    final res = await http.get(url);
    final body = jsonDecode(res.body);
    if (200 <= res.statusCode && res.statusCode < 300) {
      final List data = List.from(body['data']);
      return data.map((el) => Indication.fromJson(el));
    }
    return [];
  }

  static Future<Iterable<Model>> modelArr(
      String modelName, String filter, String query) async {
    final url =
        Uri.http(EnvVariables.API_URL, '/models/${modelName.toLowerCase()}/', {
      filter: query,
    });
    final res = await http.get(url);
    final body = jsonDecode(res.body);
    if (200 <= res.statusCode && res.statusCode < 300) {
      final List data = List.from(body['data']);
      return data.map((el) => Model.fromJson(modelName, el));
    }
    return [];
  }

  static Future<Model?> model(String modelName, String id) async {
    final url = Uri.http(
        EnvVariables.API_URL, '/models/${modelName.toLowerCase()}/one/$id');
    final res = await http.get(url);
    final body = jsonDecode(res.body);
    if (200 <= res.statusCode && res.statusCode < 300) {
      return Model.fromJson(modelName, body['data']);
    }
    return null;
  }

  static Future<Iterable<Location>> locations() async {
    final url = Uri.http(EnvVariables.API_URL, 'models/location/');
    final res = await http.get(url);
    final body = jsonDecode(res.body);
    if (200 <= res.statusCode && res.statusCode < 300) {
      final List data = List.from(body['data']);
      final ret = data.map((el) => Location.fromJson(el));
      return ret;
    }
    return [];
  }

  static Future<Iterable<Polyline>> polylines() async {
    final url = Uri.http(EnvVariables.API_URL, 'interfaces/polyline/');
    final res = await http.get(url);
    final body = jsonDecode(res.body);
    if (200 <= res.statusCode && res.statusCode < 300) {
      final List data = body['data'];
      return data.indexed.map((entrie) => Polyline(
            polylineId: PolylineId("${entrie.$1}"),
            width: 5,
            color: Colors.red,
            points: [
              ...(entrie.$2 as List<dynamic>).map(
                (el) => LatLng(
                  double.tryParse(el.elementAt(0)) ?? 0,
                  double.tryParse(el.elementAt(1)) ?? 0,
                ),
              )
            ],
          ));
    }
    return [];
  }
}
