import 'package:flutter/material.dart';
import '../home_screen.dart'; // Import your home screen

class LoginSuccessScreen extends StatelessWidget {
  const LoginSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // The back arrow is shown by default.
        // You might want to hide it to prevent users from going back into the auth flow.
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Placeholder for your verified phone illustration
              // Make sure to add an image named 'phone_verified.png' to your assets/images folder
              Image.asset(
                'assets/images/phone_verified.png',
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  // This will show a placeholder icon if the image fails to load
                  return const Icon(Icons.check_circle_outline, size: 150, color: Colors.cyan);
                },
              ),
              const SizedBox(height: 50),
              const Text(
                'Phone number\nverified',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Congratulations, your phone number has been verified. You can start using the app',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  // This is the important part:
                  // It removes all previous screens (like login, signup, verify)
                  // and makes HomeScreen the new root of the app.
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Confirm', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
