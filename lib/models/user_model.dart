class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String number;
  final List<String> roles;
  final bool kycVerified;
  final List<String> bookings;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.number,
    this.roles = const ['user'],
    this.kycVerified = false,
    this.bookings = const [],
  });

  // from Firestore to UserModel
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
    );
  }

  // To Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'number': number,
      'roles': roles,
      'kycVerified': kycVerified,
      'bookings': bookings,
    };
  }
}