import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rtdev/types/model.dart';

part 'location.g.dart';

@JsonSerializable()
class Location extends Model {
  final String name;
  final String lat;
  final String lng;
  final String alt;
  final String rad;

  Location({
    required super.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.alt,
    required this.rad,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  static List<MapEntry<String, Type>> getKeysTypes() {
    return const [
      MapEntry('name', String),
      MapEntry('lat', double),
      MapEntry('lng', double),
      MapEntry('alt', double),
      MapEntry('rad', double),
    ];
  }

  @override
  List<MapEntry<String, (Type, dynamic)>> getKeysTypesValues() {
    return [
      MapEntry('name', (String, name)),
      MapEntry('lat', (double, lat)),
      MapEntry('lng', (double, lng)),
      MapEntry('alt', (double, alt)),
      MapEntry('rad', (double, rad)),
    ];
  }

  @override
  String toString() {
    return '$name $lat $lng $rad';
  }

  @override
  String getModelName() {
    return 'Location';
  }

  @override
  String getTitle() {
    return name;
  }

  @override
  String getSubTitle() {
    return '$lat, $lng, $alt | $rad';
  }

  double getRad() {
    return double.tryParse(rad) ?? 0;
  }

  LatLng toLatLng() {
    return LatLng(
      double.tryParse(lat) ?? 0,
      double.tryParse(lng) ?? 0,
    );
  }
}
