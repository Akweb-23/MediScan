import 'package:flutter/material.dart';
import 'package:mediscanai/screens/all_categories_screen.dart';
import 'package:mediscanai/screens/settings_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mediscanai/screens/profile_screen.dart';
import 'package:mediscanai/screens/edit_profile_screen.dart';
import 'package:mediscanai/ocr_page.dart';
import 'package:mediscanai/screens/dashboard_screen.dart';
import 'package:mediscanai/screens/NearByMedicalsMapScreen.dart';
import 'package:mediscanai/models//chatbot.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _promoCurrentPage = 0;
  final PageController _promoPageController = PageController();

  final List<Map<String, dynamic>> _categories = [
    {'icon': '🧘', 'label': 'Wellness'},
    {'icon': '👁', 'label': 'Eyecare'},
    {'icon': '🦷', 'label': 'Dental'},
    {'icon': '➕', 'label': 'First Aid'},
    {'icon': '🧴', 'label': 'Skin Care'},
    {'icon': '👶', 'label': 'Baby Care'},
    {'icon': '☀', 'label': 'Sun Care'},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestLocationPermission();
    });
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      _showLocationPermissionDialog();
    }
  }

  void _showLocationPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.location_on, color: Colors.cyan, size: 50),
                const SizedBox(height: 20),
                const Text('Allow access to location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text('To access the service must be resolved track your location', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[600])),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('Allow', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    openAppSettings();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan[400],
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openMedicalRecords() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const DashboardScreen()),
    );
  }

  void _openChatbot() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ChatScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildHeader(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 20),
                  _buildPromoBanner(),
                  const SizedBox(height: 20),
                  _buildUploadButton(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AllCategoriesScreen(),
                          ));
                        },
                        child: Text('View all', style: TextStyle(color: Colors.cyan[600], fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildCategoryList(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomNavBar(),

      // IMPROVEMENT: Use the default FloatingActionButton size/style
      floatingActionButton: FloatingActionButton(
        onPressed: _openMedicalRecords,
        backgroundColor: Colors.cyan[400],
        // Use default shape for better centering in the standard notch
        shape: const CircleBorder(),
        child: const Icon(Icons.folder_shared_outlined, color: Colors.white),
        // OPTIONAL: Increase the size slightly if needed for better visual balance
        // mini: false,
      ),
      // IMPORTANT: FloatingActionButtonLocation must be exactly this for proper centering
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  SliverAppBar _buildHeader() {
    return SliverAppBar(
      backgroundColor: Colors.cyan[400],
      pinned: true,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          const Icon(Icons.location_on, color: Colors.white),
          const SizedBox(width: 8),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Delivery To', style: TextStyle(color: Colors.white, fontSize: 12)),
              Text('2386 D ward, Kolhapur', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined, color: Colors.white)),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.mic_none),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView(
            controller: _promoPageController,
            onPageChanged: (index) => setState(() => _promoCurrentPage = index),
            children: [
              _buildPromoPage(title: "We will deliver your\nmedicine on time", imagePath: 'assets/images/doctor.png'),
              _buildPromoPage(title: "Get 20% off on\nyour first order", imagePath: 'assets/images/doctor.png'),
              _buildPromoPage(title: "Free health checkup\nwith every purchase", imagePath: 'assets/images/doctor.png'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: 5),
            height: 8,
            width: _promoCurrentPage == index ? 24 : 8,
            decoration: BoxDecoration(color: _promoCurrentPage == index ? Colors.cyan : Colors.grey[300], borderRadius: BorderRadius.circular(5)),
          )),
        ),
      ],
    );
  }

  Widget _buildPromoPage({required String title, required String imagePath}) {
    return Container(
      decoration: BoxDecoration(color: Colors.cyan[300], borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.cyan[600],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Order Now'),
                ),
              ],
            ),
          ),
          const Icon(Icons.person, size: 100, color: Colors.white70),
        ],
      ),
    );
  }

  Widget _buildUploadButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => OCRPage()),
        );
      },
      icon: const Icon(Icons.document_scanner_outlined, color: Colors.white),
      label: const Text('Upload your prescription', style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: Colors.cyan[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) => Container(
          width: 80,
          margin: const EdgeInsets.only(right: 8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
                child: Text(_categories[index]['icon'], style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(height: 5),
              Text(_categories[index]['label'], textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    // The width of the space must be equal to the diameter of the FAB + 2*notchMargin
    // Default FAB diameter is 56. With notchMargin 8.0, total space is roughly 72-80.
    const double notchSpaceWidth = 72.0;

    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Group (Home and AI Chat)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNavItem(icon: Icons.home_outlined, label: 'Home', isSelected: true, onTap: () {}),
              _buildNavItem(icon: Icons.chat_bubble_outline, label: 'AI Chat', onTap: _openChatbot),
            ],
          ),

          // Central space to accommodate the FAB notch
          const SizedBox(width: notchSpaceWidth),

          // Right Group (Profile and Near Medicals)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNavItem(icon: Icons.person_pin_circle_outlined, label: 'Profile', onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ProfileScreen(),
                ));
              }),
              _buildNavItem(
                icon: Icons.location_on_outlined,
                label: 'Near Medicals',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NearbyMedicalsMapScreen(),
                  ));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, bool isSelected = false, required VoidCallback onTap}) {
    final color = isSelected ? Colors.cyan[400] : Colors.grey;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}