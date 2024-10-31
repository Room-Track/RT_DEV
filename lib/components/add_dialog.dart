// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:room_track_developerap/components/field_type.dart';
import 'package:room_track_developerap/http/app_post.dart';
import 'package:room_track_developerap/types/model.dart';

class AddDialog extends StatefulWidget {
  final String modelName;
  const AddDialog({super.key, required this.modelName});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  late final List<String> fieldNames;
  late Map<String, TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    fieldNames = Models.getModelFields(widget.modelName);
    _controllers = {for (var v in fieldNames) v: TextEditingController()};
  }

  void _onPressed() async {
    showDialog(
      context: context,
      builder: (context) => const CircularProgressIndicator(),
    );
    String? result = await AppPost.model(
      widget.modelName,
      Models.mapControllerToMapValue(_controllers),
    );
    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Text(
          result ?? 'null',
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 30,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xffECE3F4),
        ),
        padding: const EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add ${widget.modelName}",
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            ..._controllers.entries.map((entrie) =>
                FieldType(name: entrie.key, controller: entrie.value)),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(151, 81, 0, 255),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                onPressed: _onPressed,
                child: const Text(
                  "Add",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
