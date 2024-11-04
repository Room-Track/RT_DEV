import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapIcons {
  static const String user = "assets/map/user.png";

  static Future<BitmapDescriptor> get(String icon, double w, double h) async {
    return BitmapDescriptor.asset(
        ImageConfiguration(size: Size(w, h)), icon);
  }
}
