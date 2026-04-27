import 'dart:ui';
import 'package:flutter/material.dart';
import 'billing_screen.dart';

class BookingTab extends StatelessWidget {
  const BookingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // TOP BACKGROUND IMAGE & BLUR
        SizedBox(
          height: 180,
          width: double.infinity,
          child: Image.asset(
            'lib/assets/images/LandingScreenBackground.png',
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withValues(alpha: 0.6),
            height: 180,
          ),
        ),

        // FOREGROUND CONTENT
        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'My Bookings',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, fontFamily: 'Nunito', color: Color(0xFF1A1A1A)),
                ),
                const SizedBox(height: 24),

                // FILTER CHIPS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFilterChip('All', isActive: true),
                    _buildFilterChip('Active'),
                    _buildFilterChip('Pending'),
                    _buildFilterChip('Complete'),
                  ],
                ),
                const SizedBox(height: 24),

                // ACTIVE BOOKING CARD
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      // BLUE HEADER
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4A8BFE),
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('ACTIVE BOOKING', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(12)),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.check, size: 10, color: Colors.white),
                                      SizedBox(width: 4),
                                      Text('Confirmed', style: TextStyle(color: Colors.white, fontSize: 10)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            const Text('Marigold Blue Dormitory', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Nunito')),
                            const Text('Single Room · 2nd Floor', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          ],
                        ),
                      ),
                      // WHITE BODY
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildInfoRow('Move-in', 'April 28, 2026'),
                            const SizedBox(height: 12),
                            _buildInfoRow('Monthly Rent', '₱ 3,500', isBlue: true),
                            const SizedBox(height: 12),
                            _buildInfoRow('Next Due', 'May, 28, 2026', isRed: true),
                            const SizedBox(height: 12),
                            _buildInfoRow('Ref', 'DNDB-2026-04B21'),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: Divider(color: Color(0xFFE0E0E0), height: 1),
                            ),
                            Row(
                              children: [
                                // FIX: Updated to call the new sliding bottom sheet!
                                Expanded(child: _buildActionButton('Contract', isPrimary: true, onTap: () => _showContractBottomSheet(context))),
                                const SizedBox(width: 8),
                                Expanded(child: _buildActionButton('Billing', onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const BillingScreen()));
                                })),
                                const SizedBox(width: 8),
                                Expanded(child: _buildActionButton('Chat', onTap: () {})),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // PENDING BOOKING CARD
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Azure Heights Dormitory', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Nunito', color: Color(0xFF1A1A1A))),
                              Text('Double Room · Ref: DBNB-2026-04B19', style: TextStyle(fontSize: 10, color: Color(0xFF888888))),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(12)),
                            child: const Text('Pending', style: TextStyle(color: Color(0xFFD97706), fontSize: 9, fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('Requested', 'April 26, 2026'),
                      const SizedBox(height: 12),
                      _buildInfoRow('Monthly', '₱ 2,100/person'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(color: Color(0xFFE0E0E0), height: 1),
                      ),
                      const Center(
                        child: Text('Cancel Request', style: TextStyle(color: Color(0xFFDC2626), fontSize: 12, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, {bool isActive = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF4A8BFE) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? const Color(0xFF4A8BFE) : const Color(0xFFE0E0E0)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.white : const Color(0xFF888888),
          fontSize: 12,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isBlue = false, bool isRed = false}) {
    Color valueColor = const Color(0xFF1A1A1A);
    if (isBlue) valueColor = const Color(0xFF4A8BFE);
    if (isRed) valueColor = const Color(0xFFDC2626);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF666666), fontSize: 12)),
        Text(value, style: TextStyle(color: valueColor, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActionButton(String label, {bool isPrimary = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF4A8BFE) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF4A8BFE)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isPrimary ? Colors.white : const Color(0xFF4A8BFE),
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // --- NEW: SLIDING BOTTOM SHEET ---
  void _showContractBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to size itself properly
      backgroundColor: Colors.transparent, // Makes the background invisible so our rounded container floats!
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            bottom: 40.0, // Keeps it floating slightly above the bottom navigation bar
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24) // Rounded edges like your Figma design
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Wraps content tightly
              children: [
                // Little grey drag handle visual
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: const Color(0xFFE0E0E0), borderRadius: BorderRadius.circular(2)),
                ),
                const SizedBox(height: 20),

                // Header
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.handshake_outlined, size: 28),
                    SizedBox(width: 8),
                    Text('Lease Contract', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Nunito')),
                  ],
                ),
                const SizedBox(height: 24),

                // Grey Data Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      _buildDialogRow('Ref No.', 'DBNB-2026-04B21'),
                      const SizedBox(height: 8),
                      _buildDialogRow('Tenant', 'Juan Dela Cruz'),
                      const SizedBox(height: 8),
                      _buildDialogRow('Dorm', 'Marigold Blue Dormitory'),
                      const SizedBox(height: 8),
                      _buildDialogRow('Room', 'Single Room - 2F'),
                      const SizedBox(height: 8),
                      _buildDialogRow('Lease Start', 'April 28, 2026'),
                      const SizedBox(height: 8),
                      _buildDialogRow('Lease End', 'May 28, 2026'),
                      const SizedBox(height: 8),
                      _buildDialogRow('Monthly Rent', '₱ 3,500'),
                      const SizedBox(height: 8),
                      _buildDialogRow('Deposit', '₱ 3,500'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Disclaimer
                const Text(
                  'This lease agreement is digitally executed through DormBNB and is legally binding. Both parties have agreed to the terms and conditions of DormBNB and the specific house rules of Marigold Blue Dormitory.',
                  style: TextStyle(fontSize: 10, color: Color(0xFF888888), height: 1.4),
                ),
                const SizedBox(height: 16),

                // Green Badge
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(color: const Color(0xFF86EFAC), borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_box, color: Color(0xFF166534), size: 16),
                      SizedBox(width: 8),
                      Text('Digitally signed by both parties on April 28, 2026', style: TextStyle(color: Color(0xFF166534), fontSize: 10, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Blue Download Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context), // Close the bottom sheet
                    icon: const Icon(Icons.download, color: Colors.white, size: 18),
                    label: const Text('Download PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4A8BFE),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper for dialog rows
  Widget _buildDialogRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF666666))),
        Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
      ],
    );
  }
}