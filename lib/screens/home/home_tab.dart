import 'dart:ui';
import 'package:flutter/material.dart';
import 'widgets/dorm_card.dart'; // Import the reusable card
import 'widgets/notification_tab.dart';
import 'browse_tab.dart';
import '../../controller/user_controller.dart';
import '../../models/user_model.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    // MOCK DATA FOR DEMO - TODO: Replace with real API data
    final featuredDorms = [
      DormModel(
        imageUrl: 'lib/assets/images/DormAlpha.png',
        name: 'Marigold Blue Dormitory',
        location: 'Sitio Lorenzo, Brgy Ibabang Dupay, Lucena City',
        pricePerMonth: 3500,
        rating: 4.8,
        reviewCount: 42,
        amenities: ['Wifi', 'Female', 'AC'],
      ),
      DormModel(
        imageUrl: 'lib/assets/images/DormBeta.png',
        name: 'Azure Heights',
        location: 'Sitio Little Bagu...',
        pricePerMonth: 2800,
        rating: 4.5, // Mock rating
        reviewCount: 20, // Mock reviews
        amenities: ['Wifi', 'Male'],
      ),
    ];

    final budgetFriendlyDorms = [
      DormModel(
        imageUrl: 'lib/assets/images/DormCharlie.png',
        name: 'Modern Arch Dormitory',
        location: 'Sitio Lorenzo, Brgy Ibabang Dupay, Lucena City',
        pricePerMonth: 3500,
        rating: 4.7, // Mock rating
        reviewCount: 30, // Mock reviews
        amenities: ['Wifi', 'Female', 'AC'],
      ),
      DormModel(
        imageUrl: 'lib/assets/images/DormDelta.png',
        name: 'Serene Stay',
        location: 'Sitio Rainbow, B...',
        pricePerMonth: 2800,
        rating: 4.6, // Mock rating
        reviewCount: 25, // Mock reviews
        amenities: ['Wifi', 'Male'],
      ),
    ];

    return Stack(
      children: [
        // 1. TOP BLURRY BACKGROUND STACK
        SizedBox(
          height: 150,
          width: double.infinity,
          child: Image.asset(
            'lib/assets/images/LandingScreenBackground.png',
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),

        // 2. BLUR OVERLAY
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withValues(alpha: 0.5),
            height: 150,
          ),
        ),

        // 3. SAFE CONTENT COLUMN
        SafeArea(
          child: FutureBuilder<UserModel?>(
            future: UserController().getCurrentUserData(),
            builder: (context, snapshot) {
              final user = snapshot.data;
              final firstName = user?.firstName ?? 'Juan';

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HEADER SECTION
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'Nunito',
                                  ),
                                  children: [
                                    TextSpan(text: 'Dorm', style: TextStyle(color: Color(0xFF1A1A1A))),
                                    TextSpan(text: 'BNB', style: TextStyle(color: Color(0xFF4A8BFE))),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Goodmorning, $firstName!',
                                style: const TextStyle(fontSize: 13, color: Color(0xFF1A1A1A)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.search, size: 24, color: Color(0xFF1A1A1A)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const BrowseScreen(),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.notifications_none, size: 24, color: Color(0xFF1A1A1A)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const NotificationScreen(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // FEATURED DORMS SECTION
                    SectionHeader(
                      title: 'Featured Dorms',
                      onSeeAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BrowseScreen(initialCategory: 'Featured'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 310, // Height to fit card content
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        itemCount: featuredDorms.length,
                        itemBuilder: (context, index) {
                          return DormCard(dorm: featuredDorms[index]);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // BUDGET FRIENDLY SECTION
                    SectionHeader(
                      title: 'Budget Friendly',
                      onSeeAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BrowseScreen(initialCategory: 'Budget Friendly'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 310,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        itemCount: budgetFriendlyDorms.length,
                        itemBuilder: (context, index) {
                          return DormCard(dorm: budgetFriendlyDorms[index]);
                        },
                      ),
                    ),

                    const SizedBox(height: 24), // Bottom padding
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              fontFamily: 'Nunito',
              color: Color(0xFF1A1A1A),
            ),
          ),
          TextButton(
            onPressed: onSeeAll,
            child: const Text(
              'See all →',
              style: TextStyle(fontSize: 12, color: Color(0xFF4A8BFE)),
            ),
          ),
        ],
      ),
    );
  }
}
