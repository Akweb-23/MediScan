import 'package:flutter/material.dart';
// STEP 1: Import the sign up screen file you created.
import 'screens/signup_screen.dart';
import 'screens/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/welcome_image.png', height: 250),
              const SizedBox(height: 40),
              const Text(
                'Welcome to MediScan',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Login with Email', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 15),
              OutlinedButton.icon(
                onPressed: () {
                  // TODO: Implement Google Sign-In
                },
                icon: Image.asset('assets/images/google_logo.png', height: 20.0),
                label: const Text(
                  'Login with Google',
                  style: TextStyle(color: Colors.black54, fontSize: 16),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: BorderSide(color: Colors.grey[300]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  // STEP 2: Add this navigation code.
                  // This tells the app to open the SignUpScreen.
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Create ',
                    style: TextStyle(color: Colors.grey[600], fontSize: 15),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'new account',
                        style: TextStyle(
                          color: Colors.cyan[600],
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
      ),
    );
  }
}

