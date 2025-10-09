import 'package:flutter/material.dart';
import 'package:mediscanai/screens/edit_profile_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _buildProfileHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              children: [
                _buildProfileItem(
                  context,
                  icon: Icons.edit_outlined,
                  title: 'Edit Profile',
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EditProfileScreen(),
                    ));
                  },
                ),
                _buildProfileItem(context, icon: Icons.history_outlined, title: 'Order History'),
                _buildProfileItem(context, icon: Icons.settings_outlined, title: 'Settings'),
                _buildProfileItem(context, icon: Icons.payment_outlined, title: 'Payment Details'),
                _buildProfileItem(context, icon: Icons.help_outline, title: 'Help Center'),
                _buildProfileItem(context, icon: Icons.favorite_border, title: 'Favorite'),
                _buildProfileItem(context, icon: Icons.info_outline, title: 'About Us'),
              ],
            ),
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue[700],
      padding: const EdgeInsets.only(top: 60.0, bottom: 24.0),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage('https://placehold.co/100x100/EFEFEF/3B3B3B?text=CS'),
          ),
          SizedBox(height: 12),
          Text(
            'Chandrima Saha',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            'Chandrima.Saha@gmail.com',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // TODO: Implement logout logic
        },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text('Log Out', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
