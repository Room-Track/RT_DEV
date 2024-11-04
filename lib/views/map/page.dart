import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rtdev/providers/locations.dart';
import 'package:rtdev/providers/map_icons.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  static const double _zoom = 18;
  static const int _nodeStrokeWidth = 5;
  bool _fixedCamera = false;
  double? acc;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Location _location = Location();
  LatLng? _actualPos;
  BitmapDescriptor? userIcon;

  void _setupData() async {
    userIcon = await MapIcons.get(MapIcons.user, 25, 40);
    _getLocationUpdates();
  }

  @override
  void initState() {
    super.initState();
    _setupData();
  }

  Future<void> _cameraToPos(LatLng pos) async {
    final controller = await _controller.future;
    CameraPosition newPos = CameraPosition(
      target: pos,
      zoom: _zoom,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(newPos));
  }

  Future<void> _getLocationUpdates() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) return;
    serviceEnabled = await _location.requestService();

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    _location.onLocationChanged.listen((data) {
      if (data.latitude == null || data.longitude == null) return;
      _actualPos = LatLng(data.latitude!, data.longitude!);
      acc = data.accuracy;
      if (_fixedCamera) _cameraToPos(_actualPos!);
      setState(() {});
    });
  }

  void _selectNode(LatLng latlng) {
    final locs = ref.read(locationsProvider).locations;
    if (locs.isEmpty) return;
    final prox = List.generate(locs.length, (idx) {
      final loc = locs.elementAt(idx).toLatLng();
      final delta = LatLng(
        loc.latitude - latlng.latitude,
        loc.longitude - latlng.longitude,
      );
      final value = sqrt(pow(delta.latitude, 2) + pow(delta.longitude, 2)) *
          100 *
          1000; // Degree to meters
      return value <= locs.elementAt(idx).getRad() + 5 ? value : -1;
    });
    final filterProx = prox.where((n) => n > 0);
    if (filterProx.isEmpty) return;
    final minVal = filterProx.reduce(min);
    final idx = prox.indexOf(minVal);
    ref.read(locationsProvider).select(idx, context);
  }

  @override
  Widget build(BuildContext context) {
    final locs = ref.watch(locationsProvider).locations;
    final polylines = ref.watch(locationsProvider).polylines;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Map"),
        actions: [
          TextButton(
            onPressed: () {
              ref.read(locationsProvider).requestRefresh();
            },
            child: const Text("Fetch"),
          ),
          IconButton(
            onPressed: () {
              _fixedCamera = !_fixedCamera;
              if (_actualPos != null && _fixedCamera) {
                _cameraToPos(_actualPos!);
              }
              setState(() {});
            },
            icon: Icon(_fixedCamera ? Icons.gps_fixed : Icons.gps_not_fixed),
          ),
        ],
      ),
      floatingActionButton: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text("accuracy: ${acc?.toStringAsFixed(2)}m"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      body: _actualPos == null
          ? const Center(child: Text("Error with current position"))
          : GoogleMap(
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: _actualPos!,
                zoom: _zoom,
              ),
              onTap: _selectNode,
              circles: {
                Circle(
                  circleId: const CircleId("Accuracy"),
                  center: _actualPos!,
                  radius: acc != null ? acc! * 1.1 + 5 : 1,
                  fillColor: Colors.blue.shade100.withOpacity(0.3),
                  strokeColor: Colors.blue.shade100.withOpacity(0.1),
                ),
                ...locs.map((el) => Circle(
                      circleId: CircleId(el.name),
                      center: el.toLatLng(),
                      radius: el.getRad(),
                      fillColor: Colors.cyan.shade100.withOpacity(0.3),
                      strokeColor: Colors.cyan.withOpacity(0.5),
                      strokeWidth: _nodeStrokeWidth,
                    ))
              },
              markers: {
                Marker(
                  markerId: const MarkerId("Current Position"),
                  position: _actualPos!,
                  icon: userIcon ?? BitmapDescriptor.defaultMarker,
                ),
              },
              polylines: polylines.toSet(),
            ),
    );
  }
}
