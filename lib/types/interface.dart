import 'package:rtdev/types/interfaces/link.dart';
import 'package:rtdev/types/interfaces/node.dart';

abstract class Interface {
  static Interface fromJson(String inter, Map<String, dynamic> json) {
    switch (inter) {
      case 'ILink':
        return ILink.fromJson(json);

      case 'INode':
        return INode.fromJson(json);

      default:
        return INode.fromJson(json);
    }
  }

  Map<String, dynamic> toJson();
}
