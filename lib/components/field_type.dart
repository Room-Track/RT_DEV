import 'package:flutter/material.dart';
import 'package:room_track_developerap/components/inputs/coord.dart';
import 'package:room_track_developerap/components/inputs/img.dart';
import 'package:room_track_developerap/components/inputs/input_field.dart';
import 'package:room_track_developerap/components/inputs/inside.dart';
import 'package:room_track_developerap/components/inputs/type.dart';

class FieldType extends StatefulWidget {
  final String name;
  final TextEditingController controller;
  const FieldType({super.key, required this.name, required this.controller});

  @override
  State<FieldType> createState() => _FieldTypeState();
}

class _FieldTypeState extends State<FieldType> {
  @override
  Widget build(BuildContext context) {
    switch (widget.name) {
      case 'inside':
        return InsideField(controller: widget.controller);
      case 'lowestF' || 'highestF' || 'level':
        return InputField(
          controller: widget.controller,
          label: widget.name,
          hint: "Insert integer for ${widget.name}..",
          textInputType: const TextInputType.numberWithOptions(
              signed: true, decimal: false),
          hide: false,
        );
      case 'rad':
        return InputField(
          controller: widget.controller,
          label: widget.name,
          hint: "Insert double in meters for ${widget.name}..",
          textInputType: const TextInputType.numberWithOptions(
              signed: false, decimal: true),
          hide: false,
        );
      case 'type':
        return TypeField(controller: widget.controller);
      case 'lat' || 'lng':
        return CoordField(controller: widget.controller, name: widget.name);
      case 'img':
        return ImgField(controller: widget.controller);

      default:
        return InputField(
          controller: widget.controller,
          label: widget.name,
          hint: "Insert string for ${widget.name}..",
          textInputType: TextInputType.text,
          hide: false,
        );
    }
  }
}
