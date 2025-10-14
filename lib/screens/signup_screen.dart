import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'verify_screen.dart'; // We don't need this import anymore

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

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
            _buildTextField(label: 'Username', controller: _usernameController, icon: Icons.person_outline),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Contact Number',
              controller: _contactController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: 'Email',
              controller: _emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
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
            ElevatedButton(
              onPressed: _isLoading ? null : _signUpUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan[400],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Sign Up', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Future<void> _signUpUser() async {
    // Basic input validation
    if (_emailController.text.trim().isEmpty || _passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in both email and password.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // --- MODIFIED SUCCESS LOGIC ---
      if (userCredential.user != null) {
        // 1. Show the success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ Registration successful! Please log in.'),
            backgroundColor: Colors.green, // Visual feedback for success
            duration: Duration(seconds: 3),
          ),
        );

        // 2. Clear fields and navigate back to the Login screen
        _usernameController.clear();
        _contactController.clear();
        _emailController.clear();
        _passwordController.clear();

        // Navigate back to the previous screen (presumably the Login screen)
        // Ensure this is not called before the SnackBar has time to show,
        // though `pushReplacement` in the old logic also had the same concern.
        // Using `pop()` here is common for returning to the login page.
        Navigator.of(context).pop();
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An unknown error occurred during registration.';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already registered.';
      } else if (e.code == 'weak-password') {
        message = 'Password should be at least 6 characters.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is not valid.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      // Ensure loading state is reset
      setState(() => _isLoading = false);
    }
  }
}