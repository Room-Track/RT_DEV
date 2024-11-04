import 'package:json_annotation/json_annotation.dart';
import 'package:rtdev/types/model.dart';

part 'indication.g.dart';

@JsonSerializable()
class Indication extends Model {
  final String nameA;
  final String nameB;
  final String forwardInfo;
  final String backwardInfo;

  Indication({
    required super.id,
    required this.nameA,
    required this.nameB,
    required this.forwardInfo,
    required this.backwardInfo,
  });

  factory Indication.fromJson(Map<String, dynamic> json) =>
      _$IndicationFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$IndicationToJson(this);

  static List<MapEntry<String, Type>> getKeysTypes() {
    return const [
      MapEntry('nameA', String),
      MapEntry('nameB', String),
      MapEntry('forwardInfo', String),
      MapEntry('backwardInfo', String),
    ];
  }

  @override
  List<MapEntry<String, (Type, dynamic)>> getKeysTypesValues() {
    return [
      MapEntry('nameA', (String, nameA)),
      MapEntry('nameB', (String, nameB)),
      MapEntry('forwardInfo', (String, forwardInfo)),
      MapEntry('backwardInfo', (String, backwardInfo)),
    ];
  }

  @override
  String getModelName() {
    return 'Indication';
  }

  @override
  String getTitle() {
    return '$nameA <-> $nameB';
  }

  @override
  String getSubTitle() {
    return '$nameA, $nameB';
  }
}
