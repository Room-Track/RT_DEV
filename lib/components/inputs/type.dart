import 'package:flutter/material.dart';
import 'package:room_track_developerap/types/model.dart';

class TypeField extends StatefulWidget {
  final TextEditingController controller;
  const TypeField({super.key, required this.controller});

  @override
  State<TypeField> createState() => _TypeFieldState();
}

class _TypeFieldState extends State<TypeField> {
  String? _selected = Models.typeFieldNames.first;

  @override
  void initState() {
    super.initState();
    widget.controller.text = "$_selected";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        const Text("type:"),
        const Spacer(),
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: DropdownButton(
              value: _selected,
              items: [
                ...Models.typeFieldNames.map((name) => DropdownMenuItem(
                      value: name,
                      child: Text(name),
                    ))
              ],
              onChanged: (change) {
                _selected = change;
                widget.controller.text = "$change";
                setState(() {});
              },
            ),
          ),
        )
      ],
    );
  }
}
