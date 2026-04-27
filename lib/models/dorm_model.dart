/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

class DormModel {
  final String id;
  final String name;
  final String address;
  final double rate;
  final double rating;
  final int numOfRating;
  final List<String> tags;

  DormModel({
    required this.id,
    required this.name,
    required this.address,
    required this.rate,
    required this.rating,
    required this.numOfRating,
    required this.tags,
  });

  factory DormModel.fromMap(Map<String, dynamic> map, String documentId) {
    return DormModel(
      id: documentId,
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      rate: (map['rate'] ?? 0.0).toDouble(),
      rating: (map['rating'] ?? 0.0).toDouble(),
      numOfRating: map['numOfRating'] ?? 0,
      tags: List<String>.from(map['tags'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'rate': rate,
      'rating': rating,
      'numOfRating': numOfRating,
      'tags': tags,
    };
  }
}