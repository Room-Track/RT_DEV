// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rtdev/components/post_field.dart';
import 'package:rtdev/http/app_post.dart';
import 'package:rtdev/types/model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddModelButton extends StatefulWidget {
  final String name;
  final Function setStateSearch;

  const AddModelButton(
      {super.key, required this.name, required this.setStateSearch});

  @override
  State<AddModelButton> createState() => _AddModelButtonState();
}

class _AddModelButtonState extends State<AddModelButton> {
  late Map<String, (Type, TextEditingController)> controllers;

  @override
  void initState() {
    super.initState();
    controllers = {};
    Model.getKeysTypes(widget.name).forEach((entrie) {
      controllers.putIfAbsent(
        entrie.key,
        () => (
          entrie.value,
          TextEditingController(),
        ),
      );
    });
  }

  void _onSubmit(BuildContext context) async {
    for (final entrie in controllers.entries) {
      if (entrie.value.$1 != StringOrNull && entrie.value.$2.text.isEmpty) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(title: Text("Field ${entrie.key} cant be empty")));
        return;
      }
    }
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    Map<String, dynamic> json = {'id': 'testid'};
    controllers.forEach((key, value) {
      json.putIfAbsent(key, () {
        if (value.$1 == int) {
          return int.tryParse(value.$2.text) ?? 0;
        } else {
          return value.$2.text;
        }
      });
    });
    final succes = await AppPost.model(Model.fromJson(widget.name, json));
    if (Navigator.canPop(context)) Navigator.pop(context);
    if (Navigator.canPop(context)) Navigator.pop(context);
    showTopSnackBar(
      Overlay.of(context),
      succes
          ? const CustomSnackBar.success(message: "Item added")
          : const CustomSnackBar.error(message: "Failed."),
      animationDuration: const Duration(milliseconds: 200),
      displayDuration: const Duration(milliseconds: 500),
      reverseAnimationDuration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    Future(() {
      widget.setStateSearch.call();
    });
  }

  void _onPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add ${widget.name}"),
        content: Wrap(
          children: [
            ...controllers.entries.map(
              (entrie) => Column(
                children: [
                  Row(
                    children: [
                      Text("${entrie.key}:"),
                      const Spacer(),
                    ],
                  ),
                  PostField(
                    name: entrie.key,
                    type: entrie.value.$1,
                    controller: entrie.value.$2,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  _onSubmit(context);
                },
                child: const Text("Submit"),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _onPressed(context);
      },
      icon: const Icon(Icons.add),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controllers.values.forEach((entrie) {
      entrie.$2.dispose();
    });
  }
}
