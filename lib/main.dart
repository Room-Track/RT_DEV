import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:room_track_developerap/views/home_layout.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeLayout(),
      title: 'Room Track Dev',
      debugShowCheckedModeBanner: false,
    );
  }
}
