// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rtdev/components/edit_field.dart';
import 'package:rtdev/http/app_del.dart';
import 'package:rtdev/http/app_fetch.dart';
import 'package:rtdev/http/app_put.dart';
import 'package:rtdev/types/model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ObjectPage extends StatefulWidget {
  final Model model;
  final String name;
  final Function setStateSearch;
  const ObjectPage({
    super.key,
    required this.model,
    required this.name,
    required this.setStateSearch,
  });

  @override
  State<ObjectPage> createState() => _ObjectPageState();
}

class _ObjectPageState extends State<ObjectPage> {
  late Model model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  Future<void> _refreshModel() async {
    Model? refreshModel = await AppFetch.model(widget.name, model.id);
    if (refreshModel == null) return;
    model = refreshModel;
    Future(() {
      widget.setStateSearch.call();
    });
    setState(() {});
  }

  void _onPressedYes(BuildContext context) async {
    final succes = await AppDel.model(model);
    Navigator.pop(context);
    if (succes) Navigator.pop(context);
    showTopSnackBar(
      Overlay.of(context),
      succes
          ? const CustomSnackBar.success(message: "Item deleted")
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

  void _onPressedNo(BuildContext context) {
    Navigator.pop(context);
  }

  void _onPressedDelete(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Confirmation"),
              content: const Text("Are you sure you want to proceed?"),
              actions: [
                TextButton(
                  onPressed: () {
                    _onPressedYes(context);
                  },
                  child: const Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    _onPressedNo(context);
                  },
                  child: const Text("No"),
                ),
              ],
            ));
  }

  void _onPressedChange(BuildContext context, TextEditingController controller,
      String field) async {
    final succes = await AppPut.model(model, MapEntry(field, controller.text));
    Navigator.pop(context);
    showTopSnackBar(
      Overlay.of(context),
      succes
          ? const CustomSnackBar.success(message: "Item edited")
          : const CustomSnackBar.error(message: "Failed."),
      animationDuration: const Duration(milliseconds: 200),
      displayDuration: const Duration(milliseconds: 500),
      reverseAnimationDuration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    );
    _refreshModel();
  }

  void _onPressedField(BuildContext context,
      MapEntry<String, (Type, dynamic)> entrie, bool longPress) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Change ${entrie.key} ${entrie.value.$1}"),
              content: Wrap(
                children: [
                  Row(
                    children: [
                      const Text("Before"),
                      const Spacer(),
                      Text("${entrie.value.$2}")
                    ],
                  ),
                  const Divider(),
                  const Text("New"),
                  EditFieldDialog(
                    name: entrie.key,
                    type: entrie.value.$1,
                    controller: controller,
                    strict: longPress,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _onPressedChange(context, controller, entrie.key);
                  },
                  child: const Text("Change"),
                ),
                TextButton(
                  onPressed: () {
                    _onPressedNo(context);
                  },
                  child: const Text("Regret"),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.name} Object Data"),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("item id"),
            leading: const Icon(Icons.tag),
            trailing: Text(
              model.id.split('-').last,
              style: const TextStyle(fontSize: 15, color: Color(0xff6E5CA0)),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text("Item Id"),
                        content: Text(model.id),
                      ));
            },
          ),
          ...model.getKeysTypesValues().map(
                (entrie) => ListTile(
                  title: Text(entrie.key),
                  leading: Text(Model.getTypeAlias(entrie.value.$1)),
                  trailing: Text(
                    "${entrie.value.$2}",
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xff6E5CA0)),
                  ),
                  onTap: () {
                    _onPressedField(context, entrie, false);
                  },
                  onLongPress: () {
                    _onPressedField(context, entrie, true);
                  },
                ),
              ),
          const Spacer(),
          TextButton(
            onPressed: () {
              _onPressedDelete(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(151, 81, 0, 255),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            child: const Text("Delete"),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
