import 'package:flutter/material.dart';
import 'package:rtdev/types/models/building.dart';
import 'package:rtdev/types/models/indication.dart';
import 'package:rtdev/types/models/location.dart';
import 'package:rtdev/types/models/place.dart';

typedef StringOrNull = String?;

abstract class Model {
  static const names = [
    'Indication',
    'Location',
    'Building',
    'Place',
  ];

  static const typeFieldNames = [
    'ClassRoom',
    'Building',
    'ComputerLab',
  ];

  static Model fromJson(String model, Map<String, dynamic> json) {
    switch (model) {
      case 'Indication':
        return Indication.fromJson(json);
      case 'Location':
        return Location.fromJson(json);
      case 'Building':
        return Building.fromJson(json);
      default:
        return Place.fromJson(json);
    }
  }

  static List<MapEntry<String, Type>> getKeysTypes(String model) {
    switch (model) {
      case 'Indication':
        return Indication.getKeysTypes();
      case 'Location':
        return Location.getKeysTypes();
      case 'Building':
        return Building.getKeysTypes();
      default:
        return Place.getKeysTypes();
    }
  }

  static Widget getIcon(String model) {
    switch (model) {
      case 'Location':
        return const Icon(Icons.gps_fixed);
      case 'Indication':
        return const Icon(Icons.map);
      case 'Building':
        return const Icon(Icons.maps_home_work);
      default:
        return const Icon(Icons.room_preferences);
    }
  }

  static List<String> getFieldsFromName(String model) {
    switch (model) {
      case 'Indication':
        return ['nameA', 'nameB', 'forwardInfo', 'backwardInfo '];
      case 'Location':
        return ['name', 'lat', 'lng', 'alt', 'rad'];
      case 'Building':
        return ['name', 'inside', 'lowestF', 'highestF'];
      case 'Place':
        return ['name', 'type', 'level', 'img', 'ref'];
      default:
        return [];
    }
  }

  static String getTypeAlias(Type type) {
    switch (type) {
      case const (double):
        return "Decimal";
      case const (int):
        return "Integer";
      case const (String):
        return "String ";
      case const (StringOrNull):
        return "String?";
      case const (bool):
        return "Boolean";
      default:
        return "Unkown";
    }
  }

  Model({
    required this.id,
  });

  late final String id;

  String getModelName();
  String getTitle();
  String getSubTitle();

  List<MapEntry<String, (Type, dynamic)>> getKeysTypesValues();

  Map<String, dynamic> toJson();
}
