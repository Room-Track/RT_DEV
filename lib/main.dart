import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rtdev/views/home_layout.dart';

void main() async {
  await dotenv.load(fileName: 'assets/.env');
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
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
