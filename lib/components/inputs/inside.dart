import 'package:flutter/material.dart';

class InsideField extends StatefulWidget {
  final TextEditingController controller;
  const InsideField({
    super.key,
    required this.controller,
  });

  @override
  State<InsideField> createState() => _InsideFieldState();
}

class _InsideFieldState extends State<InsideField> {
  bool _value = true;

  @override
  void initState() {
    super.initState();
    widget.controller.text = '$_value';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        const Text("inside:"),
        const Spacer(),
        Card(
          child: Switch(
            value: _value,
            onChanged: (newValue) {
              _value = newValue;
              widget.controller.text = '$_value';
              setState(() {});
            },
          ),
        )
      ],
    );
  }
}
