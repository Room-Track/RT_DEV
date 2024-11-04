// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtdev/components/add_model_button.dart';
import 'package:rtdev/components/edit_field.dart';
import 'package:rtdev/components/model_tile.dart';
import 'package:rtdev/http/app_fetch.dart';
import 'package:rtdev/http/app_put.dart';
import 'package:rtdev/providers/locations.dart';
import 'package:rtdev/types/model.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GraphPage extends ConsumerStatefulWidget {
  const GraphPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _GraphPage();
}

class _GraphPage extends ConsumerState<GraphPage> {
  Model? actual;

  void _setActual(Model? loc) {
    actual = loc;
    setState(() {});
  }

  void _refreshModel() async {
    if (actual == null) return;
    Model? newLoc = await AppFetch.model('Location', actual!.id);
    ref.read(locationsProvider).selectLoc(newLoc);
  }

  void _onPressedChange(BuildContext context, TextEditingController controller,
      String field) async {
    final succes =
        await AppPut.model(actual!, MapEntry(field, controller.text));
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

  void _onPressedNo(BuildContext context) {
    Navigator.pop(context);
  }

  void _onPressedField(BuildContext context,
      MapEntry<String, (Type, dynamic)> entrie, bool longPress) {
    TextEditingController controller = TextEditingController();
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                  "Change ${entrie.key} ${entrie.value.$1} ${longPress ? "as String" : ""}"),
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
                    type: longPress ? String : entrie.value.$1,
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
    final selected = ref.watch(locationsProvider).selected;
    if (selected != actual) _setActual(selected);
    final links = ref.watch(locationsProvider).links;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Node Data"),
      ),
      body: (actual == null)
          ? const Center(child: Text("No node selected."))
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...actual!.getKeysTypesValues().map(
                        (entrie) => ListTile(
                          title: Text(entrie.key),
                          leading: Text(Model.getTypeAlias(entrie.value.$1)),
                          trailing: Text(
                            "${entrie.value.$2}",
                            style: const TextStyle(
                                fontSize: 15, color: Color(0xff6E5CA0)),
                          ),
                          onTap: () {
                            _onPressedField(context, entrie, false);
                          },
                          onLongPress: () {
                            _onPressedField(context, entrie, true);
                          },
                        ),
                      ),
                  const Divider(),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        const Text(
                          "Links",
                          style: TextStyle(fontSize: 25),
                        ),
                        const Spacer(),
                        AddModelButton(
                          name: 'Indication',
                          setStateSearch: () {
                            ref.read(locationsProvider).selectLoc(actual);
                          },
                        ),
                      ],
                    ),
                  ),
                  ...links.map((el) => ModelTile(
                        name: 'Indication',
                        model: el,
                        setStateSearch: () {
                          ref.read(locationsProvider).selectLoc(actual);
                        },
                      ))
                ],
              ),
            ),
    );
  }
}
