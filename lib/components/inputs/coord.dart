import 'package:flutter/material.dart';

class CoordField extends StatefulWidget {
  final String name;
  final TextEditingController controller;
  const CoordField({super.key, required this.controller, required this.name});

  @override
  State<CoordField> createState() => _CoordFieldState();
}

class _CoordFieldState extends State<CoordField> {
  void _onPressed() {
    // TODO Obtener LAT o LNG
    widget.controller.text = '-1.2314900';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text("${widget.name}:"),
        Text("<${widget.controller.text}>"),
        const Spacer(),
        IconButton(onPressed: _onPressed, icon: const Icon(Icons.gps_fixed))
      ],
    );
  }
}
