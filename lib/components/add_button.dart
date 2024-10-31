import 'package:flutter/material.dart';
import 'package:room_track_developerap/components/add_dialog.dart';

class AddButton extends StatelessWidget {
  final String modelName;
  const AddButton({super.key, required this.modelName});

  void _onPressed(BuildContext context) {
    showDialog(context: context, builder: (context) => AddDialog(modelName: modelName));
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          _onPressed(context);
        },
        icon: const Icon(Icons.add));
  }
}
