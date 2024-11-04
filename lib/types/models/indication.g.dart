// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'indication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Indication _$IndicationFromJson(Map<String, dynamic> json) => Indication(
      id: json['id'] as String,
      nameA: json['nameA'] as String,
      nameB: json['nameB'] as String,
      forwardInfo: json['forwardInfo'] as String,
      backwardInfo: json['backwardInfo'] as String,
    );

Map<String, dynamic> _$IndicationToJson(Indication instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nameA': instance.nameA,
      'nameB': instance.nameB,
      'forwardInfo': instance.forwardInfo,
      'backwardInfo': instance.backwardInfo,
    };
