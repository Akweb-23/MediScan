import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'ocr_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediScan',
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
