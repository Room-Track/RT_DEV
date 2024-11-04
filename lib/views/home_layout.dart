import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rtdev/views/db_model/page.dart';
import 'package:rtdev/views/graph/page.dart';
import 'package:rtdev/views/map/page.dart';

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
          NavigationDestination(
            label: 'DB Model',
            icon: SvgPicture.asset(
              'assets/db.svg',
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
          const NavigationDestination(
            label: 'Graph',
            icon: Icon(Icons.auto_graph),
          ),
          const NavigationDestination(
            label: 'Map',
            icon: Icon(Icons.map),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: const [
          DBModelPage(),
          GraphPage(),
          MapPage(),
        ],
      ),
    );
  }
}
