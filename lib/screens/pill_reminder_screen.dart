import 'package:flutter/material.dart';
import 'package:mediscanai/screens/set_reminder_screen.dart';

class PillReminderScreen extends StatefulWidget {
  const PillReminderScreen({super.key});

  @override
  State<PillReminderScreen> createState() => _PillReminderScreenState();
}

class _PillReminderScreenState extends State<PillReminderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // We have two tabs: Timeline and Missed
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pill Reminder'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {},
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'TIMELINE'),
              Tab(text: 'MISSED'),
            ],
            indicatorColor: Colors.redAccent,
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: const TabBarView(
          children: [
            // Content for the "Timeline" tab
            _EmptyReminderView(
              icon: Icons.watch_later_outlined,
              title: 'Our reminders ring exactly when you need them.',
              subtitle: 'Set a reminder now.',
            ),
            // Content for the "Missed" tab
            _EmptyReminderView(
              icon: Icons.checklist_rtl_outlined,
              title: 'Missed by choice or chance?',
              subtitle: 'Mark it here.',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const SetReminderScreen(),
            ));
          },
          backgroundColor: Colors.redAccent,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

// A helper widget for the empty state UI, to avoid repeating code.
class _EmptyReminderView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyReminderView({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.cyan.withOpacity(0.1),
              child: Icon(icon, size: 80, color: Colors.cyan[600]),
            ),
            const SizedBox(height: 30),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
