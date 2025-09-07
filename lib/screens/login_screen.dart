import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with E-mail'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            // Email Text Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter your email',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            // Password Text Field
            TextField(
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Login Button
            ElevatedButton(
              onPressed: () {
                // TODO: Implement Login Logic
                // After successful login, navigate to home screen
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
            // "Don't have account?" Text Button
            TextButton(
              onPressed: () {
                // Pop the current screen and let the welcome screen handle navigation to sign up
                Navigator.of(context).pop();
                // A better approach would be a dedicated navigation function
              },
              child: RichText(
                text: TextSpan(
                  text: "Don't have account? ",
                  style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Create new profile',
                      style: TextStyle(
                        color: Colors.orange[600], // As per your design
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
}
