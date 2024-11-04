import 'package:rtdev/types/interface.dart';
import 'package:rtdev/types/models/indication.dart';
import 'package:rtdev/types/models/place.dart';

class ILink extends Interface {
  final Place pA;
  final Place pB;
  final Indication indication;
  ILink({
    required this.pA,
    required this.pB,
    required this.indication,
  });

  factory ILink.fromJson(Map<String, dynamic> json) {
    return ILink(
      pA: json['pA'],
      pB: json['pB'],
      indication: json['indication'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'pA': pA.toJson(),
      'pB': pB.toJson(),
      'indication': indication.toJson(),
    };
  }
}
