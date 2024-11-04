import 'package:json_annotation/json_annotation.dart';
import 'package:rtdev/types/model.dart';

part 'place.g.dart';

@JsonSerializable()
class Place extends Model {
  final String name;
  final String type;
  final int level;
  final String? img;
  final String? ref;

  Place({
    required super.id,
    required this.name,
    required this.type,
    required this.level,
    this.img,
    this.ref,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaceToJson(this);

  static List<MapEntry<String, Type>> getKeysTypes() {
    return const [
      MapEntry('name', String),
      MapEntry('type', String),
      MapEntry('level', int),
      MapEntry('img', StringOrNull),
      MapEntry('ref', StringOrNull),
    ];
  }

  @override
  List<MapEntry<String, (Type, dynamic)>> getKeysTypesValues() {
    return [
      MapEntry('name', (String, name)),
      MapEntry('type', (String, type)),
      MapEntry('level', (int, level)),
      MapEntry('img', (StringOrNull, img)),
      MapEntry('ref', (StringOrNull, ref)),
    ];
  }

  @override
  String getModelName() {
    return 'Place';
  }

  @override
  String getTitle() {
    return "$name $type";
  }

  @override
  String getSubTitle() {
    return 'at $level ${ref != null ? 'from $ref' : ''}';
  }
}
