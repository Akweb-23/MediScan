import 'package:flutter/material.dart';
// Switched to a relative import, which is simpler and avoids project name errors.
import 'home_screen.dart';

// The main function is the entry point for all Flutter apps.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // Using the modern 'super.key' constructor is best practice.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediScan',
      debugShowCheckedModeBanner: false, // Hides the "debug" banner
      // Adding a theme provides consistent styling for colors and fonts across your app.
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Set HomeScreen as the starting page. Use 'const' for better performance.
      home: const HomeScreen(),
    );
  }
}

