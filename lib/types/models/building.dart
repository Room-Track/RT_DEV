import 'package:json_annotation/json_annotation.dart';
import 'package:rtdev/types/model.dart';

part 'building.g.dart';

@JsonSerializable()
class Building extends Model {
  final String name;
  final bool inside;
  final int lowestF;
  final int highestF;

  Building({
    required super.id,
    required this.name,
    required this.inside,
    required this.lowestF,
    required this.highestF,
  });

  static List<MapEntry<String, Type>> getKeysTypes() {
    return const [
      MapEntry('name', String),
      MapEntry('inside', bool),
      MapEntry('lowestF', int),
      MapEntry('highestF', int),
    ];
  }

  factory Building.fromJson(Map<String, dynamic> json) =>
      _$BuildingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BuildingToJson(this);

  @override
  List<MapEntry<String, (Type, dynamic)>> getKeysTypesValues() {
    return [
      MapEntry('name', (String, name)),
      MapEntry('inside', (bool, inside)),
      MapEntry('lowestF', (int, lowestF)),
      MapEntry('highestF', (int, highestF)),
    ];
  }

  @override
  String getModelName() {
    return 'Building';
  }

  @override
  String getTitle() {
    return "$name ${inside ? 'Inside' : 'Outside'}";
  }

  @override
  String getSubTitle() {
    return 'has floors $highestF | $lowestF';
  }
}
