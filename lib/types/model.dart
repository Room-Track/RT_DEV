import 'package:flutter/material.dart';

class Models {
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

  static List<String> getModelFields(String modelName) {
    switch (modelName) {
      case 'Indication':
        return Indication.getKeys();
      case 'Location':
        return Location.getKeys();
      case 'Building':
        return Building.getKeys();
      case 'Place':
        return Place.getKeys();
      default:
        return [];
    }
  }

  static List<dynamic> getModelValues(
      String modelName, Map<String, dynamic> json) {
    switch (modelName) {
      case 'Indication':
        return Indication.fromJSON(json).getValues();
      case 'Location':
        return Location.fromJSON(json).getValues();
      case 'Building':
        return Building.fromJSON(json).getValues();
      case 'Place':
        return Place.fromJSON(json).getValues();
      default:
        return [];
    }
  }

  static Map<String, String> mapControllerToMapValue(
      Map<String, TextEditingController> map) {
    return map.map((key, value) => MapEntry(key, value.text));
  }

  static Map<String, String> mapDynamicToMapValue(Map<String, dynamic> map) {
    return map.map((key, value) => MapEntry(key, value.toString()));
  }
}

class Indication {
  factory Indication.fromJSON(Map<String, dynamic> json) {
    return Indication(
      nameA: json['nameA'],
      nameB: json['nameB'],
      forwardInfo: json['forwardInfo'],
      backwardInfo: json['backwardInfo'],
    );
  }

  Indication({
    required this.nameA,
    required this.nameB,
    required this.forwardInfo,
    required this.backwardInfo,
  });

  List<dynamic> getValues() {
    return [nameA, nameB, forwardInfo, backwardInfo];
  }

  static List<String> getKeys() {
    return ['nameA', 'nameB', 'forwardInfo', 'backwardInfo '];
  }

  final String nameA;
  final String nameB;
  final String forwardInfo;
  final String backwardInfo;
}

class Location {
  factory Location.fromJSON(Map<String, dynamic> json) {
    return Location(
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
      rad: json['rad'],
    );
  }

  Location({
    required this.name,
    required this.lat,
    required this.lng,
    required this.rad,
  });

  List<dynamic> getValues() {
    return [name, lat, lng, rad];
  }

  static List<String> getKeys() {
    return ['name', 'lat', 'lng', 'rad'];
  }

  final String name;
  final String lat;
  final String lng;
  final String rad;
}

class Building {
  factory Building.fromJSON(Map<String, dynamic> json) {
    return Building(
      name: json['name'],
      inside: json['inside'],
      lowestF: json['lowestF'],
      highestF: json['highestF'],
    );
  }

  Building({
    required this.name,
    required this.inside,
    required this.lowestF,
    required this.highestF,
  });

  List<dynamic> getValues() {
    return [name, inside, lowestF, highestF];
  }

  static List<String> getKeys() {
    return ['name', 'inside', 'lowestF', 'highestF'];
  }

  final String name;
  final bool inside;
  final int lowestF;
  final int highestF;
}

class Place {
  factory Place.fromJSON(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      type: json['type'],
      level: json['level'],
      img: json['img'],
      ref: json['ref'],
    );
  }

  Place({
    required this.name,
    required this.type,
    required this.level,
    required this.img,
    required this.ref,
  });

  List<dynamic> getValues() {
    return [name, type, level, img, ref];
  }

  static List<String> getKeys() {
    return ['name', 'type', 'level', 'img', 'ref'];
  }

  final String name;
  final String type;
  final int level;
  final String? img;
  final String? ref;
}
