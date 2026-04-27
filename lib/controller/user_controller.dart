import "package:dormbnb/services/auth_service.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormbnb/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';


/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

class UserController {
  final AuthService authService = AuthService();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String number,
  }) async {
    try {
      UserCredential credential = await authService.createAccount(
          email: email,
          password: password
      );

      if (credential.user != null) {
        UserModel newUser = UserModel(
          id: credential.user!.uid,
          firstName: firstName,
          lastName: lastName,
          email: email,
          number: number,
        );

        await _db.collection('users').doc(newUser.id).set(newUser.toMap());
      }
    } catch (e) {
      debugPrint("Error in signUp: $e");
      rethrow;
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await authService.signIn(email: email, password: password);
  }

  Future<UserModel?> getCurrentUserData() async {
    String? uid = authService.currentUser?.uid;
    if (uid == null) return null;

    DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  Future<void> updatePhoneNumber(String newNumber) async {
    try {
      String? uid = authService.currentUser?.uid;

      if (uid == null) {
        throw Exception("User must be logged in to update phone number.");
      }

      await _db.collection('users').doc(uid).update({'number': newNumber});
    } catch (e) {
      debugPrint("Error updating phone number: $e");
      rethrow;
    }
  }

  Future<void> addBooking(String bookingId) async {
    try {
      String? uid = authService.currentUser?.uid;

      if(uid == null) {
        throw Exception("User must be logged in to add booking");
      }

      await _db.collection('users').doc(uid).update({
        'bookings': FieldValue.arrayUnion([bookingId])
      });
    } catch (e) {
      debugPrint("Error booking: $e");
      rethrow;
    }
  }

  Future<void> removeBooking(String bookingId) async {
    try {
      String? uid = authService.currentUser?.uid;

      if (uid == null) {
        throw Exception("User must be logged in to remove a booking.");
      }

      await _db.collection('users').doc(uid).update({
        'bookings': FieldValue.arrayRemove([bookingId])
      });
    } catch (e) {
      debugPrint("Error removing booking: $e");
      rethrow;
    }
  }

  Future<void> logout() async {
    await authService.signOut();
  }
}