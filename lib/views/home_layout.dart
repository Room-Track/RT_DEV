import 'package:flutter/material.dart';
import 'package:room_track_developerap/types/model.dart';
import 'package:room_track_developerap/views/model/page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _index = 1;

  void _onDestinationSelected(int newIndex) {
    _index = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Room Track Developer"),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onDestinationSelected,
        destinations: [
          ...Models.names.map((name) => NavigationDestination(
                icon: const Icon(Icons.data_saver_off),
                label: name,
              ))
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [...Models.names.map((name) => ModelPage(modelName: name))],
      ),
    );
  }
}
