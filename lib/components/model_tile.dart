import 'package:flutter/material.dart';
import 'package:rtdev/types/model.dart';
import 'package:rtdev/views/db_model/object/page.dart';

class ModelTile extends StatelessWidget {
  final String name;
  final Model model;
  final Function setStateSearch;
  const ModelTile({
    super.key,
    required this.name,
    required this.model,
    required this.setStateSearch,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.getTitle()),
      subtitle: Text(model.getSubTitle()),
      leading: const Icon(Icons.data_object),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ObjectPage(
              model: model,
              name: name,
              setStateSearch: setStateSearch,
            ),
          ),
        );
      },
    );
  }
}
