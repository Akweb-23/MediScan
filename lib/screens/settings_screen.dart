import 'package:flutter/material.dart';
import 'package:mediscanai/screens/pill_reminder_screen.dart';
import 'package:mediscanai/screens/edit_profile_screen.dart';
import 'package:mediscanai/screens/user_model.dart'; // <--- UPDATED IMPORT

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the live user data from the service
    final user = UserProfileService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: [
          _buildProfileHeader(context, user), // Pass user data
          const SizedBox(height: 16),
          _buildCarePlanCard(),
          const SizedBox(height: 16),
          _buildSettingsList(context),
        ],
      ),
      backgroundColor: Colors.grey[50],
    );
  }

  // UPDATED: Uses UserModel data
  Widget _buildProfileHeader(BuildContext context, UserModel user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hey ${user.firstName}!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(user.mobileNumber, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
          TextButton(
            onPressed: () {
              // Pass user data to the edit screen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => EditProfileScreen(user: user),
              ));
            },
            child: Row(
              children: [
                Text('Edit profile', style: TextStyle(color: Colors.cyan[600])),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.cyan[600]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ... (rest of the settings screen widgets remain the same) ...
  Widget _buildCarePlanCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Card(
        elevation: 1,
        shadowColor: Colors.cyan.withAlpha(60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Care Plan membership', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 4),
                    Text('Save more on your orders!', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.cyan[600],
                  side: BorderSide(color: Colors.cyan.shade600),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Join now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        _buildSettingsItem(Icons.shopping_bag_outlined, 'My orders'),
        _buildSettingsItem(Icons.medical_services_outlined, 'My lab tests'),
        _buildSettingsItem(Icons.chat_bubble_outline, 'My consultations'),
        _buildSettingsItem(Icons.folder_copy_outlined, 'Health Records & Insights'),
        _buildSettingsItem(Icons.star_outline, 'Rate your recent purchases'),
        _buildSettingsItem(Icons.payment_outlined, 'Manage payment methods'),
        _buildSettingsItem(
          Icons.alarm_outlined,
          'Pill reminder',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PillReminderScreen(),
            ));
          },
        ),
        const Divider(indent: 16, endIndent: 16),
        _buildSettingsItem(Icons.help_outline, 'Need help?'),
        _buildSettingsItem(Icons.settings_outlined, 'Settings'),
      ],
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }
}