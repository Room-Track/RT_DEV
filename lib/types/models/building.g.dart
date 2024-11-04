// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Building _$BuildingFromJson(Map<String, dynamic> json) => Building(
      id: json['id'] as String,
      name: json['name'] as String,
      inside: json['inside'] as bool,
      lowestF: (json['lowestF'] as num).toInt(),
      highestF: (json['highestF'] as num).toInt(),
    );

Map<String, dynamic> _$BuildingToJson(Building instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'inside': instance.inside,
      'lowestF': instance.lowestF,
      'highestF': instance.highestF,
    };
