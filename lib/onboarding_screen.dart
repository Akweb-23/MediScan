import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'welcome_screen.dart'; // We'll navigate to WelcomeScreen after the tutorial

// A model for each onboarding page's content
class OnboardingInfo {
  final String imageAsset;
  final String title;

  OnboardingInfo({required this.imageAsset, required this.title});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Controller to keep track of which page we're on
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // List of content for our onboarding pages
  final List<OnboardingInfo> _pages = [
    OnboardingInfo(
      imageAsset: 'assets/images/tutorial1.png',
      title: 'Scan Prescription',
    ),
    OnboardingInfo(
      imageAsset: 'assets/images/tutorial2.png',
      title: 'Order Medicine',
    ),
    OnboardingInfo(
      imageAsset: 'assets/images/tutorial3.png',
      title: 'AI Chat-Bot Support',
    ),
  ];

  // This function runs when the user finishes the onboarding
  void _finishOnboarding() async {
    // We use shared_preferences to save a flag that the user has seen the tutorial
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);

    // Navigate to the welcome screen and remove the onboarding screen from the back stack
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // The main content area with the PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Make sure your image assets are in the path specified!
                        Image.asset(_pages[i].imageAsset, height: 300),
                        const SizedBox(height: 40),
                        Text(
                          _pages[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // The dot indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                    (index) => buildDot(index, context),
              ),
            ),

            // The bottom navigation buttons (Skip, Next, Done)
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _finishOnboarding,
                    child: const Text('Skip', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_currentPage == _pages.length - 1) {
                        // If it's the last page, finish onboarding
                        _finishOnboarding();
                      } else {
                        // Otherwise, go to the next page
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Text(
                      // Change text to "Done" on the last page
                      _currentPage == _pages.length - 1 ? 'Done' : 'Next',
                      style: TextStyle(color: Colors.cyan[600], fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // Helper widget to build a single dot indicator
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.cyan : Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}

