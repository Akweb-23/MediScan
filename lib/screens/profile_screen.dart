import 'package:flutter/material.dart';
import 'package:mediscanai/screens/edit_profile_screen.dart';
import 'package:mediscanai/screens/user_model.dart'; // <--- UPDATED IMPORT

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the live user data from the service
    final user = UserProfileService().currentUser;

    return Scaffold(
      body: Column(
        children: [
          _buildProfileHeader(context, user),
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
                      // Pass user data to the edit screen
                      builder: (context) => EditProfileScreen(user: user),
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

  // ... (rest of the helper methods remain the same) ...

  Widget _buildProfileHeader(BuildContext context, UserModel user) {
    return Container(
      width: double.infinity,
      color: Colors.cyan[600],
      padding: const EdgeInsets.only(top: 60.0, bottom: 24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(user.avatarUrl),
          ),
          const SizedBox(height: 12),
          Text(
            '${user.firstName} ${user.lastName}',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }
  // ... (buildProfileItem and buildLogoutButton remain the same) ...
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
          backgroundColor: Colors.cyan[600],
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}