import 'package:flutter/material.dart';
import 'package:mediscanai/screens/pill_reminder_screen.dart'; // 1. IMPORT THE NEW SCREEN

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          _buildProfileHeader(),
          const SizedBox(height: 16),
          _buildCarePlanCard(),
          const SizedBox(height: 16),
          _buildSettingsList(context), // Pass context here
        ],
      ),
      backgroundColor: Colors.grey[50],
    );
  }

  // Builds the top section with user name and number
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hey there!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('9767994567', style: TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: const Row(
              children: [
                Text('Edit profile', style: TextStyle(color: Colors.redAccent)),
                SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.redAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Builds the "Care Plan" promotional card
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
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
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

  // Builds the list of tappable settings options
  Widget _buildSettingsList(BuildContext context) { // Now accepts context
    return Column(
      children: [
        _buildSettingsItem(Icons.shopping_bag_outlined, 'My orders'),
        _buildSettingsItem(Icons.medical_services_outlined, 'My lab tests'),
        _buildSettingsItem(Icons.chat_bubble_outline, 'My consultations'),
        _buildSettingsItem(Icons.folder_copy_outlined, 'Health Records & Insights'),
        _buildSettingsItem(Icons.star_outline, 'Rate your recent purchases'),
        _buildSettingsItem(Icons.payment_outlined, 'Manage payment methods'),
        _buildSettingsItem(Icons.toll_outlined, 'NeuCoins'),
        // 2. THIS IS THE UPDATED "PILL REMINDER" ITEM
        _buildSettingsItem(
          Icons.alarm_outlined,
          'Pill reminder',
          onTap: () { // Added the onTap function
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

  // 3. UPDATED HELPER WIDGET to accept an onTap function
  Widget _buildSettingsItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap, // Assign the onTap function to the ListTile
    );
  }
}

