import 'package:flutter/material.dart';
import 'package:rtdev/components/add_model_button.dart';
import 'package:rtdev/components/model_tile.dart';
import 'package:rtdev/http/app_fetch.dart';
import 'package:rtdev/types/model.dart';

class ModelSearchPage extends StatefulWidget {
  final String model;
  const ModelSearchPage({super.key, required this.model});

  @override
  State<ModelSearchPage> createState() => _ModelSearchPageState();
}

class _ModelSearchPageState extends State<ModelSearchPage> {
  late TextEditingController _controller;
  late Future<Iterable<Model>> _future;
  late final List<String> _fields;
  int _index = 0;

  void _refreshQuery() {
    if (_controller.text.isEmpty) return;
    _future = AppFetch.modelArr(
        widget.model, _fields.elementAt(_index), _controller.text);
    setState(() {});
  }

  void _fetchAll() {
    _future = AppFetch.modelArr(widget.model, '', '');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _fields = Model.getFieldsFromName(widget.model);
    _future = Future(() => []);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search ${widget.model}'s"),
        actions: [
          TextButton(onPressed: _fetchAll, child: const Text("Fetch All")),
          AddModelButton(name: widget.model, setStateSearch: _refreshQuery),
        ],
      ),
      body: Stack(
        children: [
          /**
           * Search List
           */
          SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: Text("Waiting response from server.."));
                } else if (snapshot.hasData) {
                  return Column(
                    children: [
                      const SizedBox(height: 135),
                      ...snapshot.data!.map(
                        (el) => ModelTile(
                          name: widget.model,
                          model: el,
                          setStateSearch: _refreshQuery,
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(child: Text("Connection failed."));
                }
              },
            ),
          ),
          /**
           * Search bar and settings
           */
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SearchBar(
                  controller: _controller,
                  onChanged: (value) {
                    _refreshQuery();
                  },
                  hintText: "Type something..",
                  leading: const Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                    child: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 10),
                ToggleButtons(
                  onPressed: (index) {
                    _index = index;
                    if (_controller.text.isNotEmpty) {
                      _refreshQuery();
                    } else {
                      setState(() {});
                    }
                  },
                  borderRadius: BorderRadius.circular(10),
                  isSelected:
                      List.generate(_fields.length, (idx) => idx == _index),
                  children: List.generate(
                    _fields.length,
                    (idx) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(_fields.elementAt(idx))),
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
