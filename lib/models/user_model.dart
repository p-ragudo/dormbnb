/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String number;
  final List<String> roles;
  final bool kycVerified;
  final List<String> bookings;
  final List<String> dormsOwned;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.number,
    this.roles = const ['user'],
    this.kycVerified = false,
    this.bookings = const [],
    this.dormsOwned = const [],
  });

  static const String user = 'user';
  static const String landlord = 'landlord';

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      id: documentId,
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      number: map['number'] ?? '',
      roles: List<String>.from(map['roles'] ?? []),
      kycVerified: map['kycVerified'] ?? false,
      bookings: List<String>.from(map['bookings'] ?? []),
      dormsOwned: List<String>.from(map['dormsOwned'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'number': number,
      'roles': roles,
      'kycVerified': kycVerified,
      'bookings': bookings,
      'dormsOwned': dormsOwned,
    };
  }
}