import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rtdev/http/app_fetch.dart';
import 'package:rtdev/types/model.dart';
import 'package:rtdev/types/models/location.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LocationsNotifier extends ChangeNotifier {
  Iterable<Location> locations;
  Iterable<Polyline> polylines;
  Model? selected;
  Iterable<Model> links;

  LocationsNotifier({
    required this.locations,
    required this.links,
    required this.polylines,
  });

  void select(int idx, BuildContext context) async {
    if (idx < 0 || idx >= locations.length) return;
    selected = locations.elementAt(idx);
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: "Node ${selected!.getTitle()} selected."),
      animationDuration: const Duration(milliseconds: 200),
      displayDuration: const Duration(milliseconds: 500),
      reverseAnimationDuration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    final json = selected!.toJson();
    final location = Location.fromJson(json);
    links = await AppFetch.linksOf(location.name);
    notifyListeners();
  }

  void selectLoc(Model? loc) async {
    if (loc == null) return;
    selected = loc;
    final json = selected!.toJson();
    final location = Location.fromJson(json);
    links = await AppFetch.linksOf(location.name);
    notifyListeners();
  }

  Future<void> requestRefresh() async {
    polylines = await AppFetch.polylines();
    locations = await AppFetch.locations();
    notifyListeners();
  }
}

final locationsProvider = ChangeNotifierProvider<LocationsNotifier>((ref) {
  return LocationsNotifier(locations: [], links: [], polylines: []);
});
