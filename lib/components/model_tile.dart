import 'package:flutter/material.dart';
import 'package:room_track_developerap/types/model.dart';
import 'package:room_track_developerap/views/object/page.dart';

class ModelTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final String modelName;
  const ModelTile({
    super.key,
    required this.data,
    required this.modelName,
  });

  @override
  Widget build(BuildContext context) {
    final names = Models.getModelFields(modelName);
    final keys = data.keys;
    final title = keys
        .map((key) => key.toString().contains('name') ? '${data[key]} ' : '')
        .join('');
    final fields = keys
        .map((key) => names.contains(key) &&
                !key.toString().contains('name') &&
                !key.toString().contains('info')
            ? '${data[key]} '
            : '')
        .join('');

    return ListTile(
      leading: const Icon(Icons.data_object),
      title: Text(title),
      subtitle: Text(fields),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ObjectPage(data: data, modelName: modelName)));
      },
    );
  }
}
