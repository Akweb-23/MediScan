import 'package:flutter/material.dart';

class SetReminderScreen extends StatefulWidget {
  const SetReminderScreen({super.key});

  @override
  State<SetReminderScreen> createState() => _SetReminderScreenState();
}

class _SetReminderScreenState extends State<SetReminderScreen> {
  final TextEditingController _medicineNameController = TextEditingController();

  // In a real app, this would be a dynamic list.
  // For now, we'll mock the data based on your UI design.
  final List<Map<String, dynamic>> _routines = [
    {'time': '09:00 AM', 'details': '1 Tablet with Breakfast', 'checked': false},
    {'time': '02:00 PM', 'details': '1 Tablet with Lunch', 'checked': false},
    {'time': '09:00 PM', 'details': '1 Tablet with Dinner', 'checked': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Reminder'),
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _medicineNameController,
              decoration: const InputDecoration(
                labelText: 'Enter Medicine Name',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Schedule', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildScheduleCard(),
            const SizedBox(height: 32),
            const Text('Set Routine', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildRoutineList(),
            _buildAddNewEventButton(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Add logic to save the reminder
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('SAVE', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      ),
    );
  }

  Widget _buildScheduleCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: ListTile(
        title: const Text('Daily'),
        subtitle: const Text('Until I stop'),
        trailing: Icon(Icons.edit_outlined, color: Colors.grey[600]),
        onTap: () {},
      ),
    );
  }

  Widget _buildRoutineList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _routines.length,
      itemBuilder: (context, index) {
        final routine = _routines[index];
        return CheckboxListTile(
          value: routine['checked'],
          onChanged: (bool? value) {
            setState(() {
              _routines[index]['checked'] = value!;
            });
          },
          title: Text(routine['time']),
          subtitle: Text(routine['details']),
          secondary: Icon(Icons.edit_outlined, color: Colors.grey[600]),
          controlAffinity: ListTileControlAffinity.leading,
        );
      },
    );
  }

  Widget _buildAddNewEventButton() {
    return TextButton.icon(
      onPressed: () {
        // TODO: Logic to add a new routine entry
      },
      icon: const Icon(Icons.add, color: Colors.redAccent),
      label: const Text('Add New Event', style: TextStyle(color: Colors.redAccent)),
    );
  }
}
