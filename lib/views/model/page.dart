import 'package:flutter/material.dart';
import 'package:room_track_developerap/components/add_button.dart';
import 'package:room_track_developerap/components/model_tile.dart';
import 'package:room_track_developerap/http/app_fetch.dart';
import 'package:room_track_developerap/types/model.dart';

class ModelPage extends StatefulWidget {
  final String modelName;
  const ModelPage({super.key, required this.modelName});

  @override
  State<ModelPage> createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  late final List<String> fieldNames;
  late Future<List<Map<String, dynamic>>> _future;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _future = Future(() => []);
    fieldNames = Models.getModelFields(widget.modelName);
  }

  void _refreshQuery(String query) {
    _future = AppFetch.modelArr(
        widget.modelName, fieldNames.elementAt(_index), query);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.modelName}'s data"),
        actions: [AddButton(modelName: widget.modelName), const SizedBox(width: 10)],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: Text("Waiting response from server.."));
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Column(
                      children: [
                        const SizedBox(height: 135),
                        ...snapshot.data!.map((el) =>
                            ModelTile(data: el, modelName: widget.modelName)),
                      ],
                    );
                  } else {
                    return const Center(child: Text("Connection failed.."));
                  }
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SearchBar(
                  onChanged: (value) {
                    _refreshQuery(value);
                  },
                  hintText: "Type something..",
                  leading: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 10),
                ToggleButtons(
                  isSelected:
                      List.generate(fieldNames.length, (idx) => idx == _index),
                  onPressed: (index) {
                    _index = index;
                    setState(() {});
                  },
                  borderRadius: BorderRadius.circular(10),
                  children: List.generate(
                    fieldNames.length,
                    (idx) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(fieldNames.elementAt(idx))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
