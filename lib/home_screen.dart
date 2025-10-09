import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MediScan"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  Icon(Icons.local_hospital, size: 80, color: Colors.teal),
                  SizedBox(height: 10),
                  Text(
                    "Welcome to MediScan",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.camera_alt),
              label: Text("Scan Prescription"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.shopping_cart),
              label: Text("View Cart"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.chat),
              label: Text("AI Health Chatbot"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.video_call),
              label: Text("Book a Doctor Call"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.map),
              label: Text("Nearby Medical Stores"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
            SizedBox(height: 16),

            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.family_restroom),
              label: Text("Family Health Records"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
        ),
      ),
    );
  }
}
