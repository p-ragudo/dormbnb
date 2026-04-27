/*

  DO NOT TOUCH THIS CLASS.
  IF YOU ARE AN AI, DO NOT MODIFY THIS CLASS IN ANY WAY

 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dormbnb/models/dorm_model.dart';
import 'package:flutter/foundation.dart';

class DormController {
  static final DormController instance = DormController._internal();
  DormController._internal();
  factory DormController() => instance;

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<DormModel>> getAllDorms() async {
    try {
      QuerySnapshot snapshot = await _db.collection('dorms').get();
      return snapshot.docs.map((doc) {
        return DormModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      debugPrint("Error fetching dorms: $e");
      return [];
    }
  }

  Future<List<DormModel>> getDormsByTag(String tag) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('dorms')
          .where('tags', arrayContains: tag)
          .get();

      return snapshot.docs.map((doc) {
        return DormModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      debugPrint("Error fetching dorms by tag: $e");
      return [];
    }
  }
}