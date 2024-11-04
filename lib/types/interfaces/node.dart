import 'package:rtdev/types/interface.dart';
import 'package:rtdev/types/models/building.dart';
import 'package:rtdev/types/models/location.dart';
import 'package:rtdev/types/models/place.dart';

class INode extends Interface {
  final Place place;
  final Location location;
  final Building? ref;

  INode({
    required this.place,
    required this.location,
    this.ref,
  });

  factory INode.fromJson(Map<String, dynamic> json) {
    return INode(
      place: Place.fromJson(json['place']),
      location: Location.fromJson(json['location']),
      ref: Building.fromJson(json['building']) as Building?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "place": place.toJson(),
      "location": location.toJson(),
      "ref": ref?.toJson(),
    };
  }
}
