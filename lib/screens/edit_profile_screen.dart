import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildEditProfileHeader(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildInfoField(label: 'First Name', value: 'Chandrima'),
                _buildInfoField(label: 'Last Name', value: 'Saha'),
                _buildInfoField(
                  label: 'Email',
                  value: 'Chandrima.Saha@gmail.com',
                ),
                _buildInfoField(label: 'Mobile Number', value: '01784939738'),
                _buildInfoField(
                  label: 'Password',
                  value: '**********',
                  isProtected: true,
                ),
                _buildInfoField(label: 'Date of Birth', value: '02-05-2000'),
                _buildInfoField(label: 'Gender', value: 'Female'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileHeader() {
    return Container(
      width: double.infinity,
      color: Colors.blue[700],
      padding: const EdgeInsets.only(bottom: 24.0),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              'https://placehold.co/100x100/EFEFEF/3B3B3B?text=CS',
            ),
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
