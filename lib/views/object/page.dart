// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:room_track_developerap/components/field_wrap.dart';
import 'package:room_track_developerap/http/app_del.dart';
import 'package:room_track_developerap/types/model.dart';

class ObjectPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final String modelName;

  const ObjectPage({super.key, required this.data, required this.modelName});

  void _onPressedEdit(BuildContext context) async {
    // TODO editar informacion
  }
  void _onPressedDelete(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => const CircularProgressIndicator(),
    );
    String? result = await AppDel.model(
      modelName,
      Models.mapDynamicToMapValue(data),
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
              decoration: TextDecoration.none),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$modelName Model",
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            FieldWrap(
              keys: Models.getModelFields(modelName),
              values: Models.getModelValues(modelName, data),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _onPressedEdit(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(151, 81, 0, 255),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  child: const Text(
                    "Edit",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    _onPressedDelete(context);
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(151, 81, 0, 255),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
