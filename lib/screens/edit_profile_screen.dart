import 'package:flutter/material.dart';
import 'package:mediscanai/screens/user_model.dart'; // <--- NEW IMPORT

class EditProfileScreen extends StatelessWidget {
  // UPDATED: Constructor now requires the UserModel
  final UserModel user;
  const EditProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.cyan[600], // Changed from Blue
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildEditProfileHeader(user), // Pass user data
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildInfoField(label: 'First Name', value: user.firstName), // Use user data
                _buildInfoField(label: 'Last Name', value: user.lastName), // Use user data
                _buildInfoField(
                  label: 'Email',
                  value: user.email, // Use user data
                ),
                _buildInfoField(label: 'Mobile Number', value: user.mobileNumber), // Use user data
                _buildInfoField(
                  label: 'Password',
                  value: user.passwordPlaceholder, // Use user data
                  isProtected: true,
                ),
                _buildInfoField(label: 'Date of Birth', value: user.dob), // Use user data
                _buildInfoField(label: 'Gender', value: user.gender), // Use user data
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement save logic
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile changes saved!')),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan[600],
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Changes', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  // UPDATED: Accepts UserModel
  Widget _buildEditProfileHeader(UserModel user) {
    return Container(
      width: double.infinity,
      color: Colors.cyan[600], // Changed from Blue
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.avatarUrl), // Use user data
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required String label,
    required String value,
    bool isProtected = false,
  }) {
    // ... (unchanged)
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Divider(color: Colors.grey[200]),
        ],
      ),
    );
  }
}