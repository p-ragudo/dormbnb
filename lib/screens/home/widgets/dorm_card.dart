import 'package:flutter/material.dart';

class DormModel {
  final String imageUrl;
  final String name;
  final String location;
  final int pricePerMonth;
  final double rating;
  final int reviewCount;
  final List<String> amenities;

  DormModel({
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.pricePerMonth,
    required this.rating,
    required this.reviewCount,
    required this.amenities,
  });
}

class DormCard extends StatelessWidget {
  final DormModel dorm;

  const DormCard({super.key, required this.dorm});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Specific width to enable horizontal scrolling
      margin: const EdgeInsets.only(right: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DORM IMAGE
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              dorm.imageUrl,
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Center(child: Icon(Icons.image_not_supported, size: 50)),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // DORM NAME
                Text(
                  dorm.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito',
                    color: Color(0xFF1A1A1A),
                  ),
                ),
                const SizedBox(height: 4),

                // LOCATION
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 12, color: Color(0xFF888888)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        dorm.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // PRICE AND RATING
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // PRICE
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(fontSize: 12, color: Color(0xFF4A8BFE), fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: '₱ ${dorm.pricePerMonth}'),
                          const TextSpan(text: '/mo', style: TextStyle(fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),

                    // RATING
                    Row(
                      children: [
                        const Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${dorm.rating} (${dorm.reviewCount})',
                          style: const TextStyle(fontSize: 11, color: Color(0xFF666666)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // AMENITY TAGS
                Wrap(
                  spacing: 6,
                  children: dorm.amenities.map((amenity) => Chip(
                    backgroundColor: const Color(0xFFF0F0F0),
                    label: Text(
                      amenity,
                      style: const TextStyle(fontSize: 10, color: Color(0xFF1A1A1A)),
                    ),
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide.none,
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}