import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:rtdev/types/model.dart';

class PostField extends StatefulWidget {
  final Type type;
  final String name;
  final TextEditingController controller;
  const PostField({
    super.key,
    required this.type,
    required this.controller,
    required this.name,
  });

  @override
  State<PostField> createState() => _PostFieldState();
}

class _PostFieldState extends State<PostField> {
  bool _value = true;
  String? _selected = Model.typeFieldNames.first;
  String _photoState = "Take Photo";

  void _onCameraPressed(BuildContext context) {
    print(_photoState);
  }

  void _onChanged(String value) {
    widget.controller.text = value;
    setState(() {});
  }

  void _onPressed() async {
    final location = Location();
    bool service = await location.serviceEnabled();
    if (!service) return;
    service = await location.requestService();
    if (!service) return;
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }
    final pos = await location.getLocation();
    if (pos.latitude == null || pos.longitude == null) return;

    widget.controller.text = widget.name == 'lat'
        ? pos.latitude.toString()
        : widget.name == 'lng'
            ? pos.longitude.toString()
            : pos.altitude.toString();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (widget.name == 'type') {
      widget.controller.text = "$_selected";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.name == 'type') {
      return Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: DropdownButton(
            value: _selected,
            items: [
              ...Model.typeFieldNames.map((name) => DropdownMenuItem(
                    value: name,
                    child: Text(name),
                  ))
            ],
            onChanged: (change) {
              _selected = change;
              _onChanged("$change");
            },
          ),
        ),
      );
    } else if (widget.name == 'lat' ||
        widget.name == 'lng' ||
        widget.name == 'alt') {
      return Row(
        children: [
          const SizedBox(width: 10),
          Text("<${widget.controller.text}>"),
          const Spacer(),
          IconButton(
            onPressed: _onPressed,
            icon: const Icon(Icons.gps_fixed),
          ),
        ],
      );
    } else if (widget.name == 'img') {
      return Row(
        children: [
          const SizedBox(width: 10),
          Text(_photoState),
          const Spacer(),
          IconButton(
              onPressed: () {
                _onCameraPressed(context);
              },
              icon: const Icon(
                Icons.camera_alt,
              )),
        ],
      );
    }

    return switch (widget.type) {
      const (bool) => Row(
          children: [
            Text("$_value"),
            const Spacer(),
            Switch(
              value: _value,
              onChanged: (value) {
                _value = value;
                _onChanged(value.toString());
              },
            )
          ],
        ),
      const (double) => TextField(
          onChanged: _onChanged,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      const (int) => TextField(
          onChanged: _onChanged,
          keyboardType: const TextInputType.numberWithOptions(decimal: false),
        ),
      const (String) || const (StringOrNull) || _ => TextField(
          onChanged: _onChanged,
          keyboardType: TextInputType.text,
        )
    };
  }
}
