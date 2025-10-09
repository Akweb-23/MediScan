import 'package:flutter/material.dart';
import 'home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediScan',
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

