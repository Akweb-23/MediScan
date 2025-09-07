import 'package:flutter/material.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  // A list of all your categories. You can expand this list in the future.
  final List<Map<String, dynamic>> _allCategories = const [
    {'icon': '🧘', 'label': 'Wellness'},
    {'icon': '👁️', 'label': 'Eyecare'},
    {'icon': '🦷', 'label': 'Dental'},
    {'icon': '➕', 'label': 'First Aid'},
    {'icon': '🧴', 'label': 'Skin Care'},
    {'icon': '👶', 'label': 'Baby Care'},
    {'icon': '☀️', 'label': 'Sun Care'},
    {'icon': '👩‍⚕️', 'label': 'Women\'s Care'},
    {'icon': '💪', 'label': 'Supplements'},
    {'icon': '🐾', 'label': 'Pet Care'},
    {'icon': '🌿', 'label': 'Herbal'},
    {'icon': '👴', 'label': 'Elderly Care'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Categories'),
        backgroundColor: Colors.cyan[400],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            // FIXED: Adjusted the aspect ratio to give items more height
            childAspectRatio: 0.85,
          ),
          itemCount: _allCategories.length,
          itemBuilder: (context, index) {
            // This is the widget for a single category item in the grid
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _allCategories[index]['icon'],
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _allCategories[index]['label'],
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

