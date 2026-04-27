import 'dart:ui';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. TOP BLURRY BACKGROUND STACK
          SizedBox(
            height: 180,
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
              height: 180,
            ),
          ),

          // 3. SAFE CONTENT
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BACK BUTTON & TITLE SECTION
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Row(
                          children: [
                            Icon(Icons.arrow_back, color: Color(0xFF4A8BFE), size: 24),
                            SizedBox(width: 4),
                            Text(
                              "Back",
                              style: TextStyle(
                                color: Color(0xFF4A8BFE),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Nunito',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Notifications",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF1A1A1A),
                          fontFamily: 'Nunito',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // NOTIFICATION LIST
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _buildNotificationItem(
                        icon: Icons.check,
                        iconColor: Colors.white,
                        iconBgColor: const Color(0xFF27AE60),
                        title: "Booking Confirmed!",
                        description: "Your booking at Marigold Blue Dormitory (DBNB-2026-04821) has been approved by the landlord.",
                        time: "2 hours ago",
                        isUnread: true,
                      ),
                      const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                      _buildNotificationItem(
                        icon: Icons.chat_bubble_outline,
                        iconColor: Colors.white,
                        iconBgColor: const Color(0xFF7B9DFF),
                        title: "New Message",
                        description: "Nikki Marigold: \"Okay po, pwede pa kayang lumipat sa April 28.\"",
                        time: "2 hours ago",
                        isUnread: true,
                      ),
                      const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String description,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      color: isUnread ? const Color(0xFFF7F9FC) : Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ICON
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),

          // TEXT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A1A1A),
                        fontFamily: 'Nunito',
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A8BFE),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF444444),
                    height: 1.4,
                    fontFamily: 'Nunito',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF999999),
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
