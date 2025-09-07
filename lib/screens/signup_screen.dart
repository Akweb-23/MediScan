import 'package:flutter/material.dart';
import 'verify_screen.dart'; // This will now work because we are about to create the file

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create new profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Username Field
            _buildTextField(label: 'Username', icon: Icons.person_outline),
            const SizedBox(height: 20),
            // Contact Number Field (FIXED ICON)
            _buildTextField(label: 'Contact Number', icon: Icons.phone_outlined, keyboardType: TextInputType.phone),
            const SizedBox(height: 20),
            // Email Field (FIXED ICON)
            _buildTextField(label: 'Email', icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            // Password Field
            TextField(
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: TextButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  child: Text(_isPasswordVisible ? 'Hide' : 'Show'),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // The button is labeled Login in your design, but "Continue" might be more accurate
            ElevatedButton(
              onPressed: () {
                // Navigate to the Verify Account screen
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const VerifyScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan[400],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text('Login', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            // "Already have account?" Text Button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: RichText(
                text: TextSpan(
                  text: "Already have account? ",
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Go to Login page',
                      style: TextStyle(
                        color: Colors.orange[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to avoid repetitive code for text fields
  Widget _buildTextField({required String label, required IconData icon, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}

